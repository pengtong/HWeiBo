//
//  HHStatus.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/28.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHUser, HHPhoto;
@interface HHStatus : NSObject <NSCoding>
//"created_at": "Tue May 31 17:46:55 +0800 2011",
@property (nonatomic, copy) NSString *created_at;
//"id": 11488058246,
@property (nonatomic, copy) NSString *idstr;

@property (nonatomic, strong) NSArray *spceials;

@property (nonatomic, strong) NSArray *retweetedSpceials;

@property (nonatomic, copy) NSMutableAttributedString *attrString;

@property (nonatomic, copy) NSMutableAttributedString *retweetedAttrString;

@property (nonatomic, copy) NSString *text;

//"source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
@property (nonatomic, copy) NSString *source;
//"reposts_count": 8,
@property (nonatomic, assign)int reposts_count;
//"comments_count": 9,
@property (nonatomic, assign)int comments_count;

@property (nonatomic, assign)int attitudes_count;

//@property (nonatomic, copy) NSString *thumbnail_pic;

@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, strong) HHStatus *retweeted_status;

@property (nonatomic, strong) HHUser *user;
@end
