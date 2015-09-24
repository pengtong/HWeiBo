//
//  HHStatusToolBar.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/29.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHStatusToolBar.h"
#import "HHStatus.h"

@interface HHStatusToolBar ()

@property(nonatomic, weak) UIButton *retweetButton;

@property(nonatomic, weak) UIButton *commentButton;

@property(nonatomic, weak) UIButton *attitudeButton;

@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, weak) UIView *topLineView;

@property (nonatomic, weak) UIView *buttomLineView;

@property (nonatomic, strong) NSMutableArray *DividingLine;

@end

@implementation HHStatusToolBar

- (NSMutableArray *)buttonArray
{
    if (!_buttonArray)
    {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (NSMutableArray *)DividingLine
{
    if (!_DividingLine)
    {
        _DividingLine = [NSMutableArray array];
    }
    return _DividingLine;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        
        self.retweetButton = [self setupBtnWithTitle:@"转发" image:[UIImage imageWithName:@"timeline_icon_retweet"]];
        self.commentButton = [self setupBtnWithTitle:@"评论" image:[UIImage imageWithName:@"timeline_icon_comment"]];
        self.retweetButton = [self setupBtnWithTitle:@"赞" image:[UIImage imageWithName:@"timeline_icon_unlike"]];
        
        [self setupTopLineView];
        [self setupButtomLineView];
        [self setupDividingLine];
        [self setupDividingLine];
    }
    return self;
}

- (void)setupTopLineView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    self.topLineView = lineView;
    [self addSubview:lineView];
}

- (void)setupButtomLineView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    self.buttomLineView = lineView;
    [self addSubview:lineView];
}

- (void)setupDividingLine
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:imageView];
    [self.DividingLine addObject:imageView];
}

- (UIButton *)setupBtnWithTitle:(NSString *)title image:(UIImage *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.adjustsImageWhenHighlighted = NO;
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:@"timeline_card_middlebottom_highlighted"] forState:UIControlStateHighlighted];
    [self addSubview:button];
    [self.buttonArray addObject:button];
    return button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width / self.buttonArray.count;
    CGFloat buttonY = 0;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonX = 0;
    for (int index=0; index<self.buttonArray.count; index++)
    {
        UIButton *btn = self.buttonArray[index];
        buttonX = index==0?index * buttonW:index * buttonW + 1;
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
    
    self.topLineView.frame = CGRectMake(0, 0, self.frame.size.width, 1);
    self.buttomLineView.frame = CGRectMake(0, self.height - 1, self.frame.size.width, 1);
    
    CGFloat divdingX = 0;
    CGFloat divdingY = 0;
    CGFloat divdingW = 1.5;
    CGFloat divdingH = buttonH;
    for (int index=0; index<self.DividingLine.count; index++)
    {
        UIImageView *imageView = self.DividingLine[index];
        divdingX = buttonW * index + buttonW;
        imageView.frame = CGRectMake(divdingX, divdingY, divdingW, divdingH);
    }

}

- (void)setupBtnCountWithButton:(UIButton *)btn title:(NSString *)title count:(int)count
{
    if (count > 10000)
    {
        double resute = count / 10000.0;
        title = [NSString stringWithFormat:@"%f.0万", resute];
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    else if (count < 10000 && count >= 1)
    {
        title = [NSString stringWithFormat:@"%d", count];
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
}

- (void)setStatus:(HHStatus *)status
{
    _status = status;
    
    [self setupBtnCountWithButton:self.retweetButton title:@"转发" count:status.reposts_count];
    [self setupBtnCountWithButton:self.commentButton title:@"评论" count:status.comments_count];
    [self setupBtnCountWithButton:self.attitudeButton title:@"赞" count:status.attitudes_count];
}

@end
