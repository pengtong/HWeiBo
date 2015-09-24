//
//  HHButton.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/16.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHButton.h"
#import "HHBadgeButton.h"

#define HHButtonImageTitleRate  0.6

@interface HHButton ()

@property (weak, nonatomic) HHBadgeButton *badgeButton;

@end

@implementation HHButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor colorWithRed:116/255.0 green:116/255.0 blue:116/255.0 alpha:1] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        HHBadgeButton *badgeButton = [[HHBadgeButton alloc] init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
}

- (CGRect) imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height*HHButtonImageTitleRate);
}

- (CGRect) titleRectForContentRect:(CGRect)contentRect
{
    CGFloat imageH = contentRect.size.height*HHButtonImageTitleRate;
    CGFloat titleY = contentRect.size.height - imageH;
    return CGRectMake(0, titleY , contentRect.size.width, contentRect.size.height - titleY);
}

-(void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [_item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [_item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [_item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [_item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

-(void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width;
    CGFloat badgeY = 2;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
}

@end
