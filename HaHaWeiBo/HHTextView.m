//
//  HHTextView.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/6.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHTextView.h"

#define HHTextViewPlaceholderMagir  7

@interface HHTextView () <UITextViewDelegate>

@property (nonatomic, copy) NSString *savePlaceholder;

@end

@implementation HHTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.alwaysBounceVertical = YES;
        self.placeholderColor = [UIColor lightGrayColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textChange
{
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)drawRect:(CGRect)rect
{
    if (self.hasText) return;
    
    NSMutableDictionary *attDict = [NSMutableDictionary dictionary];
    attDict[NSFontAttributeName] = self.font;
    attDict[NSForegroundColorAttributeName] = self.placeholderColor;
    CGSize placeholderWH = [self.placeholder sizeWithFont:self.font maxSize:CGSizeMake(self.width - 2 * HHTextViewPlaceholderMagir, self.height - 2 * HHTextViewPlaceholderMagir)];
    CGRect placehdRect = (CGRect){{HHTextViewPlaceholderMagir, HHTextViewPlaceholderMagir}, placeholderWH};
    
    [self.placeholder drawInRect:placehdRect withAttributes:attDict];
}

@end
