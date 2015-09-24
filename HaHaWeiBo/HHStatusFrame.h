//
//  HHStatusFrame.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/28.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHStatus;

@interface HHStatusFrame : NSObject
@property (nonatomic, strong) HHStatus *status;

/*最底层的背景*/
@property (nonatomic, assign, readonly) CGRect topViewF;
/*用户头像*/
@property (nonatomic, assign, readonly) CGRect iconViewF;
/*用户是否vip*/
@property (nonatomic, assign, readonly) CGRect vipViewF;
/*微博配图*/
@property (nonatomic, assign, readonly) CGRect photoViewF;
/*用户名字*/
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/*发微博时间*/
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/*微博来源*/
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/*微博正文*/
@property (nonatomic, assign, readonly) CGRect contentLabelF;

/*转发背景*/
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/*转发用户名字*/
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/*转发微博正文*/
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/*转发微博配图*/
@property (nonatomic, assign, readonly) CGRect retweetPhotoViewF;

/*微博工具条*/
@property (nonatomic, assign, readonly) CGRect statusToolBarF;

@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
