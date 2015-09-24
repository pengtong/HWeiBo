//
//  HHInputToolView.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/7.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHInputToolView;

typedef enum
{
    HHInputToolButtonCamera,
    HHInputToolButtonPicture,
    HHInputToolButtonMention,
    HHInputToolButtonTrend,
    HHInputToolButtonEmoticon,
}HHInputToolButtonType;

@protocol HHInputToolViewDelegate <NSObject>

@optional
- (void)inputToolView:(HHInputToolView *)toolView didClickedButtonType:(HHInputToolButtonType)buttonType;

@end

@interface HHInputToolView : UIView

@property (nonatomic, weak) id<HHInputToolViewDelegate> delegate;

@property (nonatomic, assign) BOOL emotionBtnIsSelect;

@end
