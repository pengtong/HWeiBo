//
//  HHAccountTool.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/25.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHOAuthParame.h"
#import "HHOAuthRelust.h"
@class HHAccount;

@interface HHAccountTool : NSObject

+ (void)saveAccountWithAccount:(HHAccount *)account;

+ (HHAccount *)account;

+ (void)oauthWitchParame:(HHOAuthParame *)parame success:(void (^)(HHOAuthRelust *result))success failure:(void (^)(NSError *error))failure;

@end
