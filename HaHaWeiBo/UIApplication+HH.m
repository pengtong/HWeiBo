//
//  UIApplication+HH.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/18.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "UIApplication+HH.h"

@implementation UIApplication (HH)

- (void)setAppIconBadgeNumber:(NSInteger)number
{
    UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
    
    UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
    
    [self registerUserNotificationSettings:setting];
    
    self.applicationIconBadgeNumber = number;
}

@end
