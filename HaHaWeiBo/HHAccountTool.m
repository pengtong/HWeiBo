//
//  HHAccountTool.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/25.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHAccountTool.h"
#import "HHAccount.h"
#import "HHHttpTool.h"
#import "MJExtension.h"

#define HHAccountToolAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation HHAccountTool

+ (void)saveAccountWithAccount:(HHAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:HHAccountToolAccountFilePath];
}

+ (HHAccount *)account
{
    HHAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HHAccountToolAccountFilePath];
    
    NSDate *now = [NSDate date];
    
    HHLog(@"%@", account.expires_time);
    
    if ([now compare:account.expires_time] == NSOrderedAscending)
    {
        return account;
    }
    else
    {
        return nil;
    }
}

+ (void)oauthWitchParame:(HHOAuthParame *)parame success:(void (^)(HHOAuthRelust *result))success failure:(void (^)(NSError *error))failure
{
    [HHHttpTool postWithURL:@"https://api.weibo.com/oauth2/access_token" parame:parame.keyValues success:^(id responseObject)
     {
         HHAccount *account = [HHAccount accountWithDict:responseObject];
         [HHAccountTool saveAccountWithAccount:account];
         HHOAuthRelust *relust = [[HHOAuthRelust alloc] init];
         relust.account = account;
         
         if (success)
         {
             success(relust);
         }
     }
     failure:^(NSError *error)
     {
         if (failure)
         {
             failure(error);
         }
     }];
}

@end
