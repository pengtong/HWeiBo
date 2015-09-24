//
//  HHStatusIconView.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/2.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHStatusIconView.h"
#import "HHStatus.h"
#import "HHUser.h"
#import "UIImageView+WebCache.h"

#define HHStatusIconWH  17

@interface HHStatusIconView ()

@property(nonatomic, weak) UIImageView *iconView;

@end

@implementation HHStatusIconView

- (UIImageView *)iconView
{
    if (!_iconView)
    {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.width = HHStatusIconWH;
        icon.height = HHStatusIconWH;
        _iconView = icon;
        [self addSubview:icon];
    }
    return _iconView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}

- (void)setUser:(HHUser *)user
{
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default"]];
    self.iconView.hidden = NO;
    switch (user.verified_type)
    {
        case HHUserVerifiedTypeAvatarVip:
            self.iconView.image = [UIImage imageWithName:@"avatar_vip"];
            break;
        case HHUserVerifiedTypeEnterpriseVip:
        case HHUserVerifiedTypeEnterpriseZFVip:
        case HHUserVerifiedTypeMedioVip:
        case HHUserVerifiedTypeWebVip:
        case HHUserVerifiedTypeCampusVip:
            self.iconView.image = [UIImage imageWithName:@"avatar_enterprise_vip"];
            break;
        case HHUserVerifiedTypeAvatarGrassrootVip:
            self.iconView.image = [UIImage imageWithName:@"avatar_grassroot"];
            break;
        default:
            self.iconView.hidden = YES;
            break;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    HHLog(@"image.size.width%f, image.size.height%f", self.iconView.image.size.width, self.iconView.image.size.height);
    self.iconView.x = self.width - self.iconView.width * 0.5;
    self.iconView.y = self.height - self.iconView.height * 0.5;
//    HHLog(@"%f, %f, %f", self.iconView.x, self.iconView.y, self.iconView.width);
}

@end
