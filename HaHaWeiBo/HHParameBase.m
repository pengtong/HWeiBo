//
//  HHParameBase.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/14.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHParameBase.h"
#import "HHAccount.h"
#import "HHAccountTool.h"

@implementation HHParameBase

- (instancetype)init
{
    if (self = [super init])
    {
        self.access_token = [HHAccountTool account].access_token;
    }
    return self;
}

@end
