//
//  HHUserUnreadCountRelust.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/16.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHParameBase.h"

@interface HHUserUnreadCountRelust : HHParameBase

@property (nonatomic, assign) int status;

@property (nonatomic, assign) int follower;

@property (nonatomic, assign) int cmt;

@property (nonatomic, assign) int dm;

@property (nonatomic, assign) int mention_status;

@property (nonatomic, assign) int mention_cmt;

@property (nonatomic, assign) int group;

@property (nonatomic, assign) int private_group;

@property (nonatomic, assign) int notice;

@property (nonatomic, assign) int invite;

@property (nonatomic, assign) int photo;

@property (nonatomic, assign) int messageCount;

@property (nonatomic, assign) int count;

@end
