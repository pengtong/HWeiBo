//
//  HHHttpTool.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/12.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HHHttpFileData.h"

@interface HHHttpTool : NSObject <AFMultipartFormData>

+ (void)postWithURL:(NSString *)URLString parame:(NSDictionary *)parame success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)postWithURL:(NSString *)URLString parame:(NSDictionary *)parame fileDataArray:(NSArray *)fileDataArray success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)postWithURL:(NSString *)URLString parame:(NSDictionary *)parame
        constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)getWithURL:(NSString *)URLString parame:(NSDictionary *)parame success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
