//
//  HHEmotionTool.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/17.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHEmotion;

@interface HHEmotionTool : NSObject

+ (void)addEmotion:(HHEmotion *)emotion;
+ (HHEmotion *)emotionWithString:(NSString *)emotionString;
+ (NSArray *)recentEmotions;
+ (NSArray *)defaultEmotions;
+ (NSArray *)emojiEmotions;
+ (NSArray *)lxhEmotions;
@end
