//
//  HHComposeTool.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/15.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHComposeTool.h"
#import "MJExtension.h"
#import "HHHttpTool.h"
#import "QLAssetsModel.h"

@implementation HHComposeTool

+ (void)sendStatusWithParame:(HHComposeParame *)parame success:(void (^)(HHComposeRelust *result))success failure:(void (^)(NSError *error))failure
{
    [HHHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" parame:parame.keyValues success:^(id responseObject)
    {
        HHComposeRelust *relust = [HHComposeRelust objectWithKeyValues:responseObject];
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

+ (void)sendImageStatusWithParame:(HHComposeParame *)parame fileArray:(NSArray *)fileArray success:(void (^)(HHComposeRelust *result))success failure:(void (^)(NSError *))failure
{
    NSMutableArray *fileDataArray = [NSMutableArray array];
    
    for (QLAssetsModel *assetModel in fileArray)
    {
        HHHttpFileData *fileData = [[HHHttpFileData alloc] init];
        fileData.data = UIImageJPEGRepresentation(assetModel.thumbnail, 1.0);
        fileData.name = @"pic";
        fileData.fileName = @"";
        fileData.mimeType = @"image/jpeg";
        [fileDataArray addObject:fileData];
    }
    
    [HHHttpTool postWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" parame:parame.keyValues fileDataArray:fileDataArray success:^(id responseObject)
    {
        HHComposeRelust *relust = [HHComposeRelust objectWithKeyValues:responseObject];
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
