//
//  HHUserInfoTool.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/14.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHUserInfoTool.h"
#import "HHHttpTool.h"
#import "MJExtension.h"

@implementation HHUserInfoTool

+ (void)userInfoWithParame:(HHUserInfoParame *)parame success:(void (^)(HHUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [HHHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" parame:parame.keyValues success:^(id responseObject)
    {
        if (success)
        {
            HHUserInfoResult *result = [HHUserInfoResult objectWithKeyValues:responseObject];
            success(result);
        }

    } failure:^(NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

+ (void)userUnreadCountWithParame:(HHUserUnreadCountParame *)parame success:(void (^)(HHUserUnreadCountRelust *))success failure:(void (^)(NSError *))failure
{
    [HHHttpTool getWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" parame:parame.keyValues success:^(id responseObject)
     {
         if (success)
         {
             HHUserUnreadCountRelust *result = [HHUserUnreadCountRelust objectWithKeyValues:responseObject];
             success(result);
         }
         
     } failure:^(NSError *error)
     {
         if (failure)
         {
             failure(error);
         }
     }];
}

@end
