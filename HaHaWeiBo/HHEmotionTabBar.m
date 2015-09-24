//
//  HHEmotionTabBar.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/13.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHEmotionTabBar.h"
#import "HHEmotionTabBarButton.h"
#import "UIImage+HHImage.h"

@interface HHEmotionTabBar ()

@property (nonatomic, weak) HHEmotionTabBarButton *selectButton;

@end

@implementation HHEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupButtonWithTitle:@"最近" buttonType:HHEmotionTabBarButtonTypeRecent];
        [self setupButtonWithTitle:@"默认" buttonType:HHEmotionTabBarButtonTypeDefault];
        [self setupButtonWithTitle:@"Emoji" buttonType:HHEmotionTabBarButtonTypeEmoji];
        [self setupButtonWithTitle:@"浪小花" buttonType:HHEmotionTabBarButtonTypeLxh];
    }
    return self;
}

- (void)setupButtonWithTitle:(NSString *)title buttonType:(HHEmotionTabBarButtonType)buttonType
{
    HHEmotionTabBarButton *button = [[HHEmotionTabBarButton alloc] init];
    button.tag = buttonType;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitleColor:HHColor(105, 105, 105) forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageFromContextWithColor:HHColor(239, 239, 239)] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageFromContextWithColor:HHColor(173, 173, 173)] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / self.subviews.count;
    CGFloat buttonH = self.height;
    
    for (NSInteger i = 0; i < self.subviews.count; i++)
    {
        HHEmotionTabBarButton *button = self.subviews[i];
        buttonX = buttonW * i;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        if (button.tag == HHEmotionTabBarButtonTypeDefault)
        {
            [self clickButton:button];
        }
    }
}

- (void)clickButton:(HHEmotionTabBarButton *)button
{
    if ([self.selectButton isEqual:button]) return;
    
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButtonType:)])
    {
        [self.delegate emotionTabBar:self didSelectButtonType:button.tag];
    }
}

- (void)setDelegate:(id<HHEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    [self clickButton:(HHEmotionTabBarButton *)[self viewWithTag:HHEmotionTabBarButtonTypeDefault]];
}

@end
