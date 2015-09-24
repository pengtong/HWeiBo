//
//  HHStatusPhotoListView.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/2.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHStatusPhotoListView : UIView

@property (nonatomic, strong) NSArray *photos;

+ (CGSize)sizeWithCounts:(int)counts;
@end
