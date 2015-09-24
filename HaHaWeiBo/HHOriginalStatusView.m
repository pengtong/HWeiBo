//
//  HHOriginalStatusView.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/1.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHOriginalStatusView.h"
#import "HHStatusFrame.h"
#import "HHStatus.h"
#import "HHUser.h"
#import "UIImageView+WebCache.h"
#import "HHRetweetStatusView.h"
#import "HHPhoto.h"
#import "HHStatusIconView.h"
#import "HHStatusPhotoListView.h"
#import "HHStatusTextView.h"


@interface HHOriginalStatusView ()
/*用户头像*/
@property (nonatomic, weak) HHStatusIconView *iconView;
/*用户是否vip*/
@property (nonatomic, weak) UIImageView *vipView;
/*微博配图*/
@property (nonatomic, weak) HHStatusPhotoListView *photoView;
/*用户名字*/
@property (nonatomic, weak) UILabel *nameLabel;
/*发微博时间*/
@property (nonatomic, weak) UILabel *timeLabel;
/*微博来源*/
@property (nonatomic, weak) UILabel *sourceLabel;
/*微博正文*/
@property (nonatomic, weak) HHStatusTextView *contentLabel;
/*转发背景*/
@property (nonatomic, weak) HHRetweetStatusView *retweetView;
@end

@implementation HHOriginalStatusView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        HHStatusIconView *iconView = [[HHStatusIconView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UIImageView *vipView = [[UIImageView alloc] init];
        self.vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        HHStatusPhotoListView *photoView = [[HHStatusPhotoListView alloc] init];
        [self addSubview:photoView];
        self.photoView = photoView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        nameLabel.font = HHStatusCellNameFont;
        self.nameLabel = nameLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        [self addSubview:timeLabel];
        timeLabel.font = HHStatusCellTimeFont;
        timeLabel.textColor = [UIColor colorWithRed:240/255.0 green:140/255.0 blue:19/255.0 alpha:1];
        self.timeLabel = timeLabel;
        
        UILabel *sourceLabel = [[UILabel alloc] init];
        [self addSubview:sourceLabel];
        sourceLabel.font = HHStatusCellSourceFont;
        sourceLabel.textColor = [UIColor lightGrayColor];
        self.sourceLabel = sourceLabel;
        
        HHStatusTextView *contentLabel = [[HHStatusTextView alloc] init];
        [self addSubview:contentLabel];
//        contentLabel.font = HHStatusCellContentFont;
        self.contentLabel = contentLabel;
        
        HHRetweetStatusView *retweetView = [[HHRetweetStatusView alloc] init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
    }
    return self;
}

- (void)setStatusFrame:(HHStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    HHStatus *status = statusFrame.status;
    HHStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    HHUser *user = statusFrame.status.user;
    
    self.iconView.frame = self.statusFrame.iconViewF;
    self.iconView.user = status.user;
    
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    if (user.isVip)
    {
        NSString *viptype = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:viptype]?[UIImage imageNamed:viptype]:[UIImage imageNamed:@"common_icon_membership"];
        self.vipView.frame = self.statusFrame.vipViewF;
        self.nameLabel.textColor = [UIColor orangeColor];
    }
    else
    {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    self.timeLabel.text = status.created_at;
    CGFloat timeX = self.nameLabel.x;
    CGFloat timeY = CGRectGetMaxY(self.statusFrame.nameLabelF) + HHStatusCellBorder;
    CGSize timeMaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize timeSize = [status.created_at sizeWithFont:HHStatusCellTimeFont maxSize:timeMaxSize];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + HHStatusCellBorder;
    CGFloat sourceY = self.timeLabel.y;
    CGSize sourceMaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize sourcSize = [status.source sizeWithFont:HHStatusCellSourceFont maxSize:sourceMaxSize];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourcSize};
    
    self.contentLabel.attributedText = status.attrString;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    self.contentLabel.specials = status.spceials;
    
    if (status.pic_urls.count)
    {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
        self.photoView.photos = status.pic_urls;
    }
    else
    {
        self.photoView.hidden = YES;
    }
    
    if (retweetStatus)
    {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        self.retweetView.statusFrame = self.statusFrame;
    }
    else
    {
        self.retweetView.hidden = YES;
    }
}

@end
