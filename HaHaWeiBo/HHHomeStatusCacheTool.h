//
//  HHHomeStatuseTool.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/14.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHHomeStatuseParame.h"
@class HHStatus;

@interface HHHomeStatusCacheTool : NSObject

+ (void)addStatus:(HHStatus *)status;

+ (void)addStatuses:(NSArray *)statusArray;

+ (NSArray *)statusWithParame:(HHHomeStatuseParame *)parame;
@end
