//
//  HHEmotionPageView.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/14.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHEmotionPageView.h"
#import "HHEmotion.h"
#import "HHEmotionButton.h"
#import "HHEmotionPopView.h"
#import "HHEmotionTool.h"

@interface HHEmotionPageView ()

@property (nonatomic, strong) HHEmotionPopView *popView;

@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation HHEmotionPageView

- (HHEmotionPopView *)popView
{
    if (!_popView)
    {
        _popView = [HHEmotionPopView popView];
    }
    return _popView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 1.删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;

        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}

+ (NSInteger)col
{
    if (Is_IPhone6)
    {
        return 8;
    }
    else if (Is_IPhone6Plus)
    {
        return 9;
    }
    else
    {
        return 7;
    }
}

+ (NSInteger)row
{
    if (Is_IPhone6)
    {
        return 4;
    }
    else if (Is_IPhone6Plus)
    {
        return 5;
    }
    else
    {
        return 3;
    }
}

+ (NSInteger)pageNum
{
    return [self col] * [self row] - 1;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    for (NSInteger i=0; i<emotions.count; i++)
    {
        HHEmotionButton *button = [[HHEmotionButton alloc] init];
        button.emotion = emotions[i];
        [button addTarget:self action:@selector(clickEmotionButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat inset = 20;
    NSInteger count = self.emotions.count;
    
    CGFloat btnW = (self.width - 2 * inset) / [HHEmotionPageView col];
    CGFloat btnH = (self.height - inset) / [HHEmotionPageView row];
    
    for (NSInteger i=0; i<count; i++)
    {
        HHEmotionButton *btn = self.subviews[i+1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % [HHEmotionPageView col]) * btnW;
        btn.y = inset + (i / [HHEmotionPageView col]) * btnH;
    }
    
    self.deleteButton.x = self.width - btnW - inset;
    self.deleteButton.y = self.height - btnH;
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
}

-(void)deleteClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:HHEmotionDeleteNotification object:nil];
}

- (HHEmotionButton *)emotionButtonWithLocation:(CGPoint)location
{
    NSInteger count = self.emotions.count;
    for (NSInteger i=0; i<count; i++)
    {
        HHEmotionButton *btn = self.subviews[i+1];
        if (CGRectContainsPoint(btn.frame, location))
        {
            return btn;
        }
    }
    
    return nil;
}
         
- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:recognizer.view];
    HHEmotionButton *btn = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self.popView removeFromSuperview];
            if (btn)
            {
                [self selectEmotion:btn.emotion];
            }
            break;
            
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            [self.popView showFrom:btn];
            break;
    
        default:
            break;
    }
}

- (void)selectEmotion:(HHEmotion *)emotion
{
    [HHEmotionTool addEmotion:emotion];
    NSDictionary *dict = @{HHEmotionKey :emotion};
    [[NSNotificationCenter defaultCenter] postNotificationName:HHEmotionDidSelectNotification object:nil userInfo:dict];
}

- (void)clickEmotionButton:(HHEmotionButton *)button
{
    [self.popView showFrom:button];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    [self selectEmotion:button.emotion];
}

@end
