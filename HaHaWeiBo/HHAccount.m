//
//  HHAccount.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/24.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHAccount.h"

@implementation HHAccount

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.access_token = dict[@"access_token"];
        self.expires_in = [dict[@"expires_in"] longLongValue] ;
        self.remind_in = [dict[@"remind_in"] longLongValue];
        self.uid = [dict[@"uid"] longLongValue];
        self.expires_time = [[NSDate date] dateByAddingTimeInterval:self.expires_in];
    }
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeInt64ForKey:@"expires_in"];
        self.remind_in = [decoder decodeInt64ForKey:@"remind_in"];
        self.uid = [decoder decodeInt64ForKey:@"uid"];
        self.expires_time = [decoder decodeObjectForKey:@"expires_time"];
        self.userName = [decoder decodeObjectForKey:@"userName"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [encoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [encoder encodeInt64:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expires_time forKey:@"expires_time"];
    [encoder encodeObject:self.userName forKey:@"userName"];
}

@end
