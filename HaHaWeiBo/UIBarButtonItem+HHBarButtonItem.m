//
//  UIBarButtonItem+HHBarButtonItem.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/17.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "UIBarButtonItem+HHBarButtonItem.h"
#import "UIImage+HHImage.h"

@implementation UIBarButtonItem (HHBarButtonItem)

+ (instancetype) itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
