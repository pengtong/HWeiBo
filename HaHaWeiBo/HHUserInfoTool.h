//
//  HHUserInfoTool.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/14.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHUserInfoParame.h"
#import "HHUserInfoResult.h"
#import "HHUserUnreadCountParame.h"
#import "HHUserUnreadCountRelust.h"

@interface HHUserInfoTool : NSObject

+ (void)userInfoWithParame:(HHUserInfoParame *)parame success:(void (^)(HHUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)userUnreadCountWithParame:(HHUserUnreadCountParame *)parame success:(void (^)(HHUserUnreadCountRelust *result))success failure:(void (^)(NSError *error))failure;

@end
