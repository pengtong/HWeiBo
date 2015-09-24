//
//  HHTabBar.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/16.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHTabBar.h"
#import "UIImage+HHImage.h"
#import "HHButton.h"

@interface HHTabBar ()
@property (weak, nonatomic) HHButton *selectButton;
@property (weak, nonatomic) UIButton *plusButton;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@end

@implementation HHTabBar

- (NSMutableArray *)buttonArray
{
    if (!_buttonArray)
    {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        
        UIButton *plus = [UIButton buttonWithType:UIButtonTypeCustom];
        [plus setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plus setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plus setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plus setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plus.bounds = (CGRect){CGPointZero, plus.currentBackgroundImage.size};
        [plus addTarget:self action:@selector(chickPlusButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plus];
        self.plusButton = plus;
    }
    return  self;
}


- (void)chickPlusButton
{
    if ([self.delegate respondsToSelector:@selector(tabBardidSelectPlusButton)])
    {
        [self.delegate tabBardidSelectPlusButton];
    }
}

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem
{
    HHButton *button = [[HHButton alloc] init];
    [self addSubview:button];
    
    button.item = tabBarItem;
    
    [button addTarget:self action:@selector(chickButton:) forControlEvents:UIControlEventTouchDown];
    
    if (self.buttonArray.count == 0)
    {
        [self chickButton:button];
    }
    
    [self.buttonArray addObject:button];
}

- (void) chickButton:(HHButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)])
    {
        [self.delegate tabBar:self didSelectButtonFrom:(int)self.selectButton.tag to:(int)button.tag];
    }
    
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonY = 0;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    self.plusButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGFloat buttonX = 0;
    
    for (int index = 0; index < self.buttonArray.count; index++)
    {
        HHButton *button = self.buttonArray[index];
        buttonX = index * buttonW;
        if (index > 1)
        {
            buttonX += buttonW;
        }
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = index;

    }
}
@end
