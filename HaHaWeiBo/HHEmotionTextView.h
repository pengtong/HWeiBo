//
//  HHEmotionTextView.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/15.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHTextView.h"
@class HHEmotion;

@interface HHEmotionTextView : HHTextView

- (void)insertEmotion:(HHEmotion *)emotion;

- (NSString *)fullText;

@end
