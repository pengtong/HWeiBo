//
//  HHEmotionKeyboard.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/13.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHEmotionKeyboard.h"
#import "HHEmotionListView.h"
#import "HHEmotionTabBar.h"
#import "HHEmotion.h"
#import "HHEmotionTool.h"

@interface HHEmotionKeyboard ()<HHEmotionTabBarDelegate>

@property (nonatomic, strong) HHEmotionListView *emotionRecentView;

@property (nonatomic, strong) HHEmotionListView *emotionDefaultView;

@property (nonatomic, strong) HHEmotionListView *emotionEmojiView;

@property (nonatomic, strong) HHEmotionListView *emotionLxhView;

@property (nonatomic, weak) HHEmotionTabBar *emotionTabBar;

@property (nonatomic, weak) HHEmotionListView *showListView;

@end

@implementation HHEmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        HHEmotionTabBar *emotionTabBar = [[HHEmotionTabBar alloc] init];
        emotionTabBar.delegate = self;
        self.emotionTabBar = emotionTabBar;
        [self addSubview:emotionTabBar];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected) name:HHEmotionDidSelectNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)emotionDidSelected
{
    self.emotionRecentView.emotionData = [HHEmotionTool recentEmotions];
}

- (HHEmotionListView *)emotionRecentView
{
    if (!_emotionRecentView)
    {
        _emotionRecentView = [[HHEmotionListView alloc] init];
        _emotionRecentView.emotionData = [HHEmotionTool recentEmotions];
    }
    return _emotionRecentView;
}

- (HHEmotionListView *)emotionDefaultView
{
    if (!_emotionDefaultView)
    {
        _emotionDefaultView = [[HHEmotionListView alloc] init];
        _emotionDefaultView.emotionData = [HHEmotionTool defaultEmotions];
    }
    return _emotionDefaultView;
}

- (HHEmotionListView *)emotionEmojiView
{
    if (!_emotionEmojiView)
    {
        _emotionEmojiView = [[HHEmotionListView alloc] init];
        _emotionEmojiView.emotionData = [HHEmotionTool emojiEmotions];
    }
    return _emotionEmojiView;
}

- (HHEmotionListView *)emotionLxhView
{
    if (!_emotionLxhView)
    {
        _emotionLxhView = [[HHEmotionListView alloc] init];
        _emotionLxhView.emotionData = [HHEmotionTool lxhEmotions];
    }
    return _emotionLxhView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.emotionTabBar.x = 0;
    self.emotionTabBar.height = 44;
    self.emotionTabBar.y = self.height - self.emotionTabBar.height;
    self.emotionTabBar.width = self.width;
    
    self.showListView.x = 0;
    self.showListView.y = 0;
    self.showListView.width = self.width;
    self.showListView.height = self.emotionTabBar.y;
}

#pragma mark - HHEmotionTabBarDelegate
- (void)emotionTabBar:(HHEmotionTabBar *)emotionTabBar didSelectButtonType:(HHEmotionTabBarButtonType)buttonType
{
    [self.showListView removeFromSuperview];
    
    switch (buttonType)
    {
        case HHEmotionTabBarButtonTypeRecent:
            [self addSubview:self.emotionRecentView];
            break;
        case HHEmotionTabBarButtonTypeDefault:
            [self addSubview:self.emotionDefaultView];
            break;
        case HHEmotionTabBarButtonTypeEmoji:
            [self addSubview:self.emotionEmojiView];
            break;
        case HHEmotionTabBarButtonTypeLxh:
            [self addSubview:self.emotionLxhView];
            break;
        default:
            break;
    }
    
    self.showListView = [self.subviews lastObject];
    
    [self setNeedsLayout];
}

@end
