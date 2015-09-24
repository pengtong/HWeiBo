//
//  HHInputToolView.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/7.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHInputToolView.h"

@interface HHInputToolView ()

@property (nonatomic, weak) UIButton *emotionBtn;

@end


@implementation HHInputToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        [self setupBtnWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tagType:HHInputToolButtonCamera];
        [self setupBtnWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tagType:HHInputToolButtonPicture];
        [self setupBtnWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tagType:HHInputToolButtonMention];
        [self setupBtnWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tagType:HHInputToolButtonTrend];
        [self setupBtnWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tagType:HHInputToolButtonEmoticon];
    }
    return self;
}

- (void)setupBtnWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tagType:(HHInputToolButtonType)tagType
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    btn.tag = tagType;
    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    if (tagType == HHInputToolButtonEmoticon)
    {
        self.emotionBtn = btn;
    }
}

- (void)clickButton:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(inputToolView:didClickedButtonType:)])
    {
        [self.delegate inputToolView:self didClickedButtonType:(HHInputToolButtonType)btn.tag];
    }
}

- (void)setEmotionBtnIsSelect:(BOOL)emotionBtnIsSelect
{
    _emotionBtnIsSelect = emotionBtnIsSelect;
    
    UIImage *normalImage = [UIImage imageWithName:@"compose_emoticonbutton_background"];
    UIImage *higtImage = [UIImage imageWithName:@"compose_emoticonbutton_background_highlighted"];
    
    if (emotionBtnIsSelect)
    {
        normalImage = [UIImage imageWithName:@"compose_keyboardbutton_background"];
        higtImage = [UIImage imageWithName:@"compose_keyboardbutton_background_highlighted"];
    }
    
    [self.emotionBtn setImage:normalImage forState:UIControlStateNormal];
    [self.emotionBtn setImage:higtImage forState:UIControlStateHighlighted];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    
    for (int index=0; index<self.subviews.count; index++)
    {
        UIButton *btn = self.subviews[index];
        buttonX = index * buttonW;
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

@end
