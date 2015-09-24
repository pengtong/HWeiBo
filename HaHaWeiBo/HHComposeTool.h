//
//  HHComposeTool.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/15.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHComposeParame.h"
#import "HHComposeRelust.h"
#import "HHHttpFileData.h"

@interface HHComposeTool : NSObject

+ (void)sendStatusWithParame:(HHComposeParame *)parame success:(void (^)(HHComposeRelust *result))success failure:(void (^)(NSError *error))failure;

+ (void)sendImageStatusWithParame:(HHComposeParame *)parame fileArray:(NSArray *)fileArray success:(void (^)(HHComposeRelust *result))success failure:(void (^)(NSError *error))failure;

@end
