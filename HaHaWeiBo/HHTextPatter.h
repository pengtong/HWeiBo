//
//  HHTextPatter.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/20.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHTextPatter : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSRange  rang;

@property (nonatomic, assign, getter=isSpecial) BOOL special;

@property (nonatomic, assign, getter=isEmotion) BOOL emotion;
@end
