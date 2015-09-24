//
//  HHEmotionButton.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/15.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHEmotionButton.h"
#import "NSString+Emoji.h"

@implementation HHEmotionButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.adjustsImageWhenHighlighted = NO;
}

- (void)setEmotion:(HHEmotion *)emotion
{
    _emotion = emotion;
    if (emotion.png)
    {
        [self setImage:[UIImage imageWithName:emotion.png] forState:UIControlStateNormal];
    }
    else if (emotion.code)
    {
        [self setTitle:[emotion.code emoji] forState:UIControlStateNormal];
    }
}

@end
