//
//  HHStatusPhotoView.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/2.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHStatusPhotoView.h"
#import "HHPhoto.h"
#import "UIImageView+WebCache.h"

@interface HHStatusPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation HHStatusPhotoView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(HHPhoto *)photo
{
    _photo = photo;
    
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];

    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.width, self.height);
}

@end
