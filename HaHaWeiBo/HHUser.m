//
//  HHUser.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/26.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHUser.h"
#import "MJExtension.h"

@implementation HHUser

MJCodingImplementation

- (void)setMbrank:(int)mbrank
{
    _mbrank = mbrank;
    
    _vip = mbrank > 2;
}

@end
