//
//  HHEmotionTextAttachment.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/16.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHEmotionTextAttachment.h"
#import "HHEmotion.h"

@implementation HHEmotionTextAttachment

- (void)setEmotion:(HHEmotion *)emotion
{
    _emotion = emotion;
    self.image = [UIImage imageWithName:emotion.png];
}

@end
