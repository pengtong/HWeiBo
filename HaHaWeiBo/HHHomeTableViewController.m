//
//  HHHomeTableViewController.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/16.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHHomeTableViewController.h"
#import "UIBarButtonItem+HHBarButtonItem.h"
#import "HHTitleButton.h"
#import "UIImage+HHImage.h"
#import "HHAccount.h"
#import "HHAccountTool.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"
#import "HHUser.h"
#import "UIView+MJ.h"
#import "HHStatus.h"
#import "HHStatusFrame.h"
#import "HHStatusCell.h"
#import "MJRefresh.h"
#import "HHHttpTool.h"
#import "HHHomeStatuseDataTool.h"
//#import "HHHomeStatuseTool.h"
#import "HHUserInfoTool.h"

@interface HHHomeTableViewController ()

@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation HHHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    //初始化导航栏
    [self setupNavBar];
    //设置用户数据
    [self setupUserInfo];
    //加载微博数据
    //[self setupStatusData];
    
    [self setupRefreshControl];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewScrollPositionNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, HHStatusCellBorder, 0);
}

- (NSMutableArray *)statusFrames
{
    if (!_statusFrames)
    {
        _statusFrames = [NSMutableArray array];
    }
    
    return _statusFrames;
}

- (void)setupNavBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendsearch)];

    HHTitleButton *titleButton = [HHTitleButton titleButton];
    NSString *name = [HHAccountTool account].userName;
    titleButton.frame = CGRectMake(0, 0, 200, 40);
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];

    [titleButton addTarget:self action:@selector(chickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

- (void) chickTitleButton:(HHTitleButton *)titleButton
{
    [UIView animateWithDuration:0.5f animations:^{
        titleButton.imageView.transform = CGAffineTransformRotate(titleButton.imageView.transform, -M_PI);
    }];
}

- (void)friendsearch
{

}

- (void)pop
{

}

- (void)setupUserInfo
{
    HHUserInfoParame *parame = [[HHUserInfoParame alloc] init];
    parame.access_token = [HHAccountTool account].access_token;
    parame.uid = @([HHAccountTool account].uid);
    
    __unsafe_unretained typeof(self)weakSelf = self;
    [HHUserInfoTool userInfoWithParame:parame success:^(HHUserInfoResult *result)
    {
        HHAccount *account = [HHAccountTool account];
        account.userName = result.name;
        [HHAccountTool saveAccountWithAccount:account];

        UIButton *button = (UIButton *)weakSelf.navigationItem.titleView;
        [button setTitle:result.name forState:UIControlStateNormal];
        [button layoutIfNeeded];
        [button setNeedsLayout];
    }
    failure:^(NSError *error)
    {
        HHLog(@"访问失败");
    }];
}

- (void)setupRefreshControl
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh:)];
    self.tableView.header = header;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh:)];
    self.tableView.footer = footer;
    [self.tableView.header beginRefreshing];
}

- (void)dealloc
{

}

- (void)footerRefresh:(MJRefreshFooter *)footer
{ 
    HHHomeStatuseParame *parame = [[HHHomeStatuseParame alloc] init];
    if (self.statusFrames.count)
    {
        HHStatusFrame *statusFrame = [self.statusFrames lastObject];
        HHStatus *status = statusFrame.status;
        long long max_id = [status.idstr longLongValue] - 1;
        parame.max_id = [NSNumber numberWithLongLong:max_id];
    }
    __unsafe_unretained typeof(self)weakSelf = self;
    [HHHomeStatuseDataTool homeWithParame:parame success:^(HHHomeStatuseResult *result)
    {
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (HHStatus *status in result.statuses)
        {
            HHStatusFrame *statusFrame = [[HHStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        [self.statusFrames addObjectsFromArray:statusFrameArray];
        [footer endRefreshing];
        [weakSelf.tableView reloadData];
    }
    failure:^(NSError *error)
    {
        [footer endRefreshing];
        HHLog(@"访问失败--%s,%s,%d",__FILE__, __FUNCTION__, __LINE__);
    }];
    
}


- (void)refresh
{
    if ([self.tabBarItem.badgeValue intValue] != 0 && (self.tableView.header.state != MJRefreshStateRefreshing))
    {
        [self.tableView.header beginRefreshing];
    }
}

- (void)headerRefresh:(MJRefreshNormalHeader *)header
{
    HHHomeStatuseParame *parame = [[HHHomeStatuseParame alloc] init];
    if (self.statusFrames.count)
    {
        HHStatusFrame *statusFrame = [self.statusFrames firstObject];
        HHStatus *status = statusFrame.status;
        long long since_id = [status.idstr longLongValue];
        parame.since_id = [NSNumber numberWithLongLong:since_id];
    }
    
    __unsafe_unretained typeof(self) weakSelf = self;
    
    [HHHomeStatuseDataTool homeWithParame:parame success:^(HHHomeStatuseResult *result)
    {
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (HHStatus *status in result.statuses)
        {
            HHStatusFrame *statusFrame = [[HHStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tempArray;
        [weakSelf.tableView reloadData];
        [header endRefreshing];
        weakSelf.tabBarItem.badgeValue = nil;
        [weakSelf showNewStatusesCount:result.statuses.count];
    }
    failure:^(NSError *error)
    {
        [header endRefreshing];
    }];
    
}

- (void)showNewStatusesCount:(NSUInteger)count
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithRed:253/255.0 green:98/255.0 blue:42/255.0 alpha:1.0];
    if (count != 0)
    {
        label.text = [NSString stringWithFormat:@"当前有%lu新微博", (unsigned long)count];
    }
    else
    {
        label.text = [NSString stringWithFormat:@"当前没有新微博"];
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 30;
    label.y = self.navigationController.navigationBar.height - label.height;
    [self.navigationController.navigationBar insertSubview:label atIndex:0];
    
    [UIView animateWithDuration:0.5f animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished)
    {
        [UIView animateWithDuration:0.5f delay:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

#pragma mark - Table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHStatusCell *cell = [HHStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
