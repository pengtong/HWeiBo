//
//  QLAssetNavigationBar.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/9.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "QLAssetNavigationContorller.h"
#import "QLAssetsCommonHeader.h"

@implementation QLAssetNavigationContorller

+(void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    UIImage *barImage = [UIImage imageNamed:kQLAssetFileName(@"nav_background")];
    barImage = [barImage stretchableImageWithLeftCapWidth:barImage.size.width * 0.5 topCapHeight:barImage.size.height * 0.5];
    [bar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *attDict = [NSMutableDictionary dictionary];
    attDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [bar setTitleTextAttributes:attDict];
    
}

@end
