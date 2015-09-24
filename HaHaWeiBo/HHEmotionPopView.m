//
//  HHEmotionPopView.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/15.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHEmotionPopView.h"
#import "HHEmotion.h"
#import "HHEmotionButton.h"

@interface HHEmotionPopView ()

@property (weak, nonatomic) IBOutlet HHEmotionButton *button;

@end

@implementation HHEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HHEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFrom:(HHEmotionButton *)button
{
    self.button.emotion = button.emotion;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) - self.height;
    self.centerX = CGRectGetMidX(btnFrame);
}

@end
