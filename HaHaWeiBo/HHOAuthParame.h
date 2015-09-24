//
//  HHOAuthParame.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/15.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHOAuthParame : NSObject

@property (nonatomic, copy) NSString *client_id;

@property (nonatomic, copy) NSString *client_secret;

@property (nonatomic, copy) NSString *grant_type;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *redirect_uri;
@end
