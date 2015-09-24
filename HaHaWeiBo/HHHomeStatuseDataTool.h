//
//  HHHomeStatuseDataTool.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/14.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHHomeStatuseParame.h"
#import "HHHomeStatuseResult.h"

@interface HHHomeStatuseDataTool : NSObject

+ (void)homeWithParame:(HHHomeStatuseParame *)parame success:(void (^)(HHHomeStatuseResult *result))success failure:(void (^)(NSError *error))failure;

@end
