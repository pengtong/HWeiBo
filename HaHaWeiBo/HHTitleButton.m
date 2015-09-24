//
//  HHTitleButton.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/22.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHTitleButton.h"
#import "UIImage+HHImage.h"
#import "NString+Extend.h"
#import "UIView+MJ.h"

#define HHTitleButtonImageW     20
#define HHTitleButtonMagr       5


@interface HHTitleButton ()

@property (nonatomic, strong) UIFont *titleFont;

@property(nonatomic, assign) CGFloat imageX;

@end

@implementation HHTitleButton

+ (instancetype)titleButton
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.adjustsImageWhenHighlighted = NO;
    [self setBackgroundImage:[UIImage imageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleFont = [UIFont boldSystemFontOfSize:19];
    self.titleLabel.font = self.titleFont;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleW = [self.currentTitle sizeWithFont:self.titleFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    CGFloat titleX = (contentRect.size.width - titleW - HHTitleButtonImageW - HHTitleButtonMagr) / 2;
    CGFloat titleH = contentRect.size.height;
    self.imageX = titleX + titleW + HHTitleButtonMagr;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageW = HHTitleButtonImageW;

    return CGRectMake(self.imageX, imageY, imageW, imageH);
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    self.titleLabel.x = self.imageView.x;
//    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
//}

//- (void)setImage:(UIImage *)image forState:(UIControlState)state
//{
//    [super setImage:image forState:state];
//    [self sizeToFit];
//}
//
//- (void)setTitle:(NSString *)title forState:(UIControlState)state
//{
//    [super setTitle:title forState:state];
//    [self sizeToFit];
//}

@end
