//
//  HHHomeStatuseDataTool.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/14.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHHomeStatuseDataTool.h"
#import "HHHttpTool.h"
#import "HHStatus.h"
#import "MJExtension.h"
#import "HHStatusFrame.h"
#import "HHStatusCell.h"
#import "HHHomeStatusCacheTool.h"

@interface HHHomeStatuseDataTool ()

@end



@implementation HHHomeStatuseDataTool

+ (void)homeWithParame:(HHHomeStatuseParame *)parame success:(void (^)(HHHomeStatuseResult *))success failure:(void (^)(NSError *error))failure
{
    NSArray *statusArray = [HHHomeStatusCacheTool statusWithParame:parame];
    
    if (statusArray.count)
    {
        HHHomeStatuseResult *result = [[HHHomeStatuseResult alloc] init];
        result.statuses = statusArray;
        
        if (success)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(result);
            });
        }
    }
    else
    {
        [HHHttpTool getWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" parame:parame.keyValues success:^(id responseObject)
        {
            if (success)
            {
                HHHomeStatuseResult *result = [HHHomeStatuseResult objectWithKeyValues:responseObject];
                
                [HHHomeStatusCacheTool addStatuses:result.statuses];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(result);
                });
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
}
@end
