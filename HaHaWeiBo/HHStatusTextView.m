//
//  HHStatusTextView.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/22.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHStatusTextView.h"
#import "HHSpecial.h"

#define BackgroundViewTag  999

@implementation HHStatusTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.editable = NO;
        self.scrollEnabled = NO;
    }
    return self;
}

- (void)setSpecials:(NSArray *)specials
{
    _specials = specials;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    BOOL contains = NO;
    for (HHSpecial *special in self.specials)
    {
        self.selectedRange = special.rang;
        NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
        self.selectedRange = NSMakeRange(0, 0);

        for (UITextSelectionRect *selectionRect in rects)
        {
            CGRect rect = selectionRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0) continue;
            
            if (CGRectContainsPoint(rect, point))
            {
                contains = YES;
                HHLog(@"%@>>>>>>%@>>>>>>>%@", special.text, NSStringFromRange(special.rang), NSStringFromCGRect(rect));
                UIView *temp = [[UIView alloc] init];
                temp.backgroundColor = [UIColor greenColor];
                temp.frame = rect;
                temp.tag = BackgroundViewTag;
                temp.layer.cornerRadius = 4;
                [self insertSubview:temp atIndex:0];
                break;
            }
        }
        
        if (contains)
        {
            for (UITextSelectionRect *selectionRect in rects)
            {
                CGRect rect = selectionRect.rect;
                if (rect.size.width == 0 || rect.size.height == 0) continue;
                
                if (CGRectContainsPoint(rect, point))
                {
                    UIView *temp = [[UIView alloc] init];
                    temp.backgroundColor = [UIColor greenColor];
                    temp.frame = rect;
                    temp.tag = BackgroundViewTag;
                    temp.layer.cornerRadius = 4;
                    [self insertSubview:temp atIndex:0];
                }
            }
            break;
        }
        
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *view in self.subviews)
    {
        if (view.tag == BackgroundViewTag) {
            [view removeFromSuperview];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    for (HHSpecial *special in self.specials)
    {
        self.selectedRange = special.rang;
        NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
        self.selectedRange = NSMakeRange(0, 0);
        
        for (UITextSelectionRect *selectionRect in rects)
        {
            CGRect rect = selectionRect.rect;
            if (rect.size.width <= 0 || rect.size.height <= 0) continue;
            
            if (CGRectContainsPoint(rect, point))
            {
                return YES;
            }
        }
    }
    
    return NO;
}

@end
