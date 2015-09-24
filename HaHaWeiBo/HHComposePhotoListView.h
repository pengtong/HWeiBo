//
//  HHComposePhotoListView.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/8.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHComposePhotoListView;

@protocol HHComposePhotoListViewDelegate <NSObject>

@optional
- (void)composePhotoListView:(HHComposePhotoListView *)photosView clickPhotosIndex:(NSUInteger)index;

@end


@interface HHComposePhotoListView : UIView
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, weak) id<HHComposePhotoListViewDelegate> delegate;
@end
