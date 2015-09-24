//
//  HHTabBar.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/16.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHTabBar;

@protocol HHTabBarDelegate <NSObject, UITabBarDelegate>
@optional
- (void) tabBar:(HHTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to;

- (void) tabBardidSelectPlusButton;
@end

@interface HHTabBar : UIView

@property (weak, nonatomic) id<HHTabBarDelegate> delegate;

- (void) addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem;

@end
