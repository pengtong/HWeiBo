//
//  HHEmotion.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/14.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHEmotion.h"
#import "MJExtension.h"

@interface HHEmotion ()<NSCopying>

@end

@implementation HHEmotion
MJCodingImplementation

- (BOOL)isEqual:(HHEmotion *)other
{
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}

@end
