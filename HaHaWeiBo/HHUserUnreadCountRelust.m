//
//  HHUserUnreadCountRelust.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/16.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHUserUnreadCountRelust.h"

@implementation HHUserUnreadCountRelust

/*
 follower	int	新粉丝数
 cmt	int	新评论数
 dm	int	新私信数
 mention_status	int	新提及我的微博数
 mention_cmt	int	新提及我的评论数
 group	int	微群消息未读数
 private_group	int	私有微群消息未读数
 notice	int	新通知未读数
 invite	int	新邀请未读数
 badge	int	新勋章数
 photo	int	相册消息未读数
 */

- (int)messageCount
{
    return self.cmt + self.dm + self.mention_status + self.mention_cmt + self.group + self.private_group + self.notice + self.invite + self.photo;
}

- (int)count
{
    return self.messageCount + self.status + self.follower;
}

@end
