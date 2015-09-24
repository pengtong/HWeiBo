//
//  HHSatatusCell.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/28.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHStatusCell.h"
#import "HHStatusFrame.h"
#import "HHUser.h"
#import "HHStatus.h"
#import "UIImageView+WebCache.h"
#import "HHStatusToolBar.h"
#import "HHRetweetStatusView.h"
#import "HHOriginalStatusView.h"

@interface HHStatusCell ()
/*最底层的背景*/
@property (nonatomic, weak) HHOriginalStatusView *topView;

/*微博工具条*/
@property (nonatomic, weak) HHStatusToolBar *statusToolBar;
@end

@implementation HHStatusCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupCell];
        //原创微博
        [self setupOriginalSubViews];
        //底部工具条
        [self setupStatusToolSubViews];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"statuscell";
    HHStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[HHStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    return cell;
}

- (void)setupCell
{
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];
    self.selectedBackgroundView = bg;
}

- (void)setupOriginalSubViews
{
    HHOriginalStatusView *topView = [[HHOriginalStatusView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}


- (void)setupStatusToolSubViews
{
    HHStatusToolBar *statusToolBar = [[HHStatusToolBar alloc] init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
}

- (void)setupOriginalData
{
    self.topView.frame = self.statusFrame.topViewF;
    self.topView.statusFrame = self.statusFrame;
}

- (void)setupToolBar
{
    self.statusToolBar.frame = self.statusFrame.statusToolBarF;
    self.statusToolBar.status = self.statusFrame.status;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += HHStatusCellBorder;
    frame.size.height -= HHStatusCellBorder;
    [super setFrame:frame];
}

- (void)setStatusFrame:(HHStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    //原创微博
    [self setupOriginalData];
    //设置工具条
    [self setupToolBar];
}
@end
