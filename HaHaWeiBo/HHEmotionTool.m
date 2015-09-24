//
//  HHEmotionTool.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/17.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHEmotionTool.h"
#import "HHEmotion.h"
#import "MJExtension.h"

#define HHEmotionFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentEmotion.data"]

static NSMutableArray *_recentEmotion;
static NSArray *_defaultEmotion, *_emojiEmotion, *_lxhEmotion;

@implementation HHEmotionTool

+ (void)initialize
{
    _recentEmotion = (NSMutableArray *)[self recentEmotions];
    if (_recentEmotion == nil)
    {
        _recentEmotion = [NSMutableArray array];
    }
}

+ (void)addEmotion:(HHEmotion *)emotion
{
    [_recentEmotion removeObject:emotion];
    [_recentEmotion insertObject:emotion atIndex:0];
    [NSKeyedArchiver archiveRootObject:_recentEmotion toFile:HHEmotionFilePath];
}

+ (HHEmotion *)emotionWithString:(NSString *)emotionString
{
    for (HHEmotion *emotion in [self defaultEmotions])
    {
        if ([emotion.chs isEqualToString:emotionString])
        {
            return emotion;
        }
    }
    
    for (HHEmotion *emotion in [self lxhEmotions])
    {
        if ([emotion.chs isEqualToString:emotionString])
        {
            return emotion;
        }
    }
    
    return nil;
}

+ (NSArray *)recentEmotions
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:HHEmotionFilePath];
}

+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotion)
    {
        _defaultEmotion = [NSArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotion = [HHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultEmotion;
}

+ (NSArray *)emojiEmotions
{
    if (!_emojiEmotion)
    {
        _emojiEmotion = [NSArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotion = [HHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiEmotion;
}

+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotion)
    {
        _lxhEmotion = [NSArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotion = [HHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhEmotion;
}
@end
