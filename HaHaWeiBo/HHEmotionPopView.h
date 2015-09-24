//
//  HHEmotionPopView.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/15.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHEmotion, HHEmotionButton;

@interface HHEmotionPopView : UIView

+ (instancetype)popView;

- (void)showFrom:(HHEmotionButton *)button;

@end
