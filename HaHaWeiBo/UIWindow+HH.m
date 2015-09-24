//
//  UIWindow+HH.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/25.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "UIWindow+HH.h"
#import "HHTabBarViewController.h"
#import "HHNewfeatureViewController.h"

@implementation UIWindow (HH)


- (void)switchContorller
{
    NSString *key = @"CFBundleVersion";
    NSUserDefaults *newfeatureDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [newfeatureDefaults stringForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion])
    {
        self.rootViewController = [[HHTabBarViewController alloc] init];
    }
    else
    {
        self.rootViewController = [[HHNewfeatureViewController alloc] init];
        [newfeatureDefaults setObject:currentVersion forKey:key];
        [newfeatureDefaults synchronize];
    }
}
@end
