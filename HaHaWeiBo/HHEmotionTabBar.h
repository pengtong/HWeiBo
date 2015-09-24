//
//  HHEmotionTabBar.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/13.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHEmotionTabBar;

typedef NS_ENUM(NSInteger, HHEmotionTabBarButtonType) {
    HHEmotionTabBarButtonTypeRecent = 1,
    HHEmotionTabBarButtonTypeDefault   = 2,
    HHEmotionTabBarButtonTypeEmoji  = 3,
    HHEmotionTabBarButtonTypeLxh   = 4,
};

@protocol HHEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(HHEmotionTabBar *)emotionTabBar didSelectButtonType:(HHEmotionTabBarButtonType)buttonType;

@end

@interface HHEmotionTabBar : UIView

@property (nonatomic, weak) id<HHEmotionTabBarDelegate> delegate;

@end
