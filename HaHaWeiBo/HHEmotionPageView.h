//
//  HHEmotionPageView.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/14.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Is_IPhone6 ([UIScreen mainScreen].bounds.size.height==667.0f || [UIScreen mainScreen].bounds.size.height==375.0f)

#define Is_IPhone6Plus ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)

@interface HHEmotionPageView : UIView

@property (nonatomic, strong) NSArray *emotions;

+ (NSInteger)col;

+ (NSInteger)row;

+ (NSInteger)pageNum;

@end
