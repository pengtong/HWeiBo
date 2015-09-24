//
//  HHCommon.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/4.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#ifndef HaHaWeiBo_HHCommon_h
#define HaHaWeiBo_HHCommon_h

#import <Foundation/Foundation.h>
#import "UIView+MJ.h"
#import "NString+Extend.h"
#import "UIImage+HHImage.h"
#import "UIApplication+HH.h"

//账号相关
#define HHAppKey        @"2849808896"
#define HHAppSecret     @"74da15b07f1ee11d7d8ccf7547240b94"
#define HHRedirectUrl   @"http://www.baidu.com"

#define HHLoginUrl      [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", HHAppKey,HHRedirectUrl]


#define HHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0  blue:(b)/255.0  alpha:1]

#ifdef DEBUG
#define HHLog(...) NSLog(__VA_ARGS__)
#else
#define HHLog(...) nil
#endif

//微博cell里面元素间距
#define HHStatusCellBorder          10
//微博cell博主名称字体
#define HHStatusCellNameFont            [UIFont systemFontOfSize:13]
//微博cell转发的博主名称字体
#define HHStatusCellRetweetNameFont     HHStatusCellNameFont
//微博cell时间字体
#define HHStatusCellTimeFont            [UIFont systemFontOfSize:10]
//微博cell来源字体
#define HHStatusCellSourceFont          HHStatusCellTimeFont
//微博cell正文字体
#define HHStatusCellContentFont         [UIFont systemFontOfSize:14]
//微博cell转发微博正文字体
#define HHStatusCellRetweetContentFont  [UIFont systemFontOfSize:13]


//微博cell配图宽高
#define HHStatusPhotoListWH     80
//微博cell配图间距
#define HHStatusPhotoListMagir  2
//微博cell配图张数
#define HHStatusPhotoCounts     9
//表情选中通知
#define HHEmotionKey                   @"HHEmotionKey" 
#define HHEmotionDidSelectNotification @"HHEmotionDidSelectNotification"
#define HHEmotionDeleteNotification    @"HHEmotionDelNotification"
#endif
