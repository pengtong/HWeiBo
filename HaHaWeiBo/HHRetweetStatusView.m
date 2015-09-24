//
//  HHRetweetStatusView.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/1.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHRetweetStatusView.h"
#import "HHStatus.h"
#import "HHUser.h"
#import "HHStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "HHPhoto.h"
#import "HHStatusPhotoListView.h"
#import "HHStatusTextView.h"

@interface HHRetweetStatusView ()
/*转发用户名字*/
@property (nonatomic, weak) UILabel *retweetNameLabel;
/*转发微博正文*/
@property (nonatomic, weak) HHStatusTextView *retweetContentLabel;
/*转发微博配图*/
@property (nonatomic, weak) HHStatusPhotoListView *retweetPhotoView;
@end

@implementation HHRetweetStatusView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizeImageWithName:@"timeline_retweet_background" left:0.8 top:0.5];
        
        HHStatusPhotoListView *retweetPhotoView = [[HHStatusPhotoListView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
        
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        [self addSubview:retweetNameLabel];
        retweetNameLabel.textColor = [UIColor colorWithRed:67/255.0 green:107/255.0 blue:163/255.0 alpha:1];
        retweetNameLabel.font = HHStatusCellRetweetNameFont;
        self.retweetNameLabel = retweetNameLabel;
        
        HHStatusTextView *retweetContentLabel = [[HHStatusTextView alloc] init];
        [self addSubview:retweetContentLabel];
//        retweetContentLabel.font = HHStatusCellRetweetContentFont;
        retweetContentLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
        self.retweetContentLabel = retweetContentLabel;
    }
    return self;
}

- (void)setStatusFrame:(HHStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    HHStatus *retweetStatus = statusFrame.status.retweeted_status;
    
    NSString *retweetName = [NSString stringWithFormat:@"@%@", retweetStatus.user.name];
    self.retweetNameLabel.text = retweetName;
    self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
    
    self.retweetContentLabel.attributedText = retweetStatus.retweetedAttrString;
    self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
    self.retweetContentLabel.specials = retweetStatus.spceials;
    
    if (retweetStatus.pic_urls.count)
    {
        self.retweetPhotoView.hidden = NO;
        self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
        self.retweetPhotoView.photos = retweetStatus.pic_urls;
    }
    else
    {
        self.retweetPhotoView.hidden = YES;
    }
}

@end
