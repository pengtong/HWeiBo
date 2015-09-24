//
//  HHHttpTool.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/12.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHHttpTool.h"

@interface HHHttpTool ()

@end

@implementation HHHttpTool

+ (void)postWithURL:(NSString *)URLString parame:(NSDictionary *)parame success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr POST:URLString parameters:parame success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)URLString parame:(NSDictionary *)parame fileDataArray:(NSArray *)fileDataArray success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr POST:URLString parameters:parame constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        for (HHHttpFileData *fileData in fileDataArray)
        {
            [formData appendPartWithFileData:fileData.data name:fileData.name fileName:fileData.fileName mimeType:fileData.mimeType];
        }
    }
    success:^(NSURLSessionDataTask *task, id responseObject)
    {
        if (success)
        {
            success(responseObject);
        }
    }
    failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)URLString parame:(NSDictionary *)parame
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr POST:URLString parameters:parame constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        if (block)
        {
            block(formData);
        }
    }
    success:^(NSURLSessionDataTask *task, id responseObject)
    {
         if (success)
         {
             success(responseObject);
         }
    }
    failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}

+ (void)getWithURL:(NSString *)URLString parame:(NSDictionary *)parame success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:URLString parameters:parame success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}

@end
