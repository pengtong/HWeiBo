//
//  HHNewfeatureViewController.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/22.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHNewfeatureViewController.h"
#import "HHTabBarViewController.h"
#import "MBProgressHUD+MJ.h"

#define HHNewfeatureImageCount      3

#define HHNewfeatureButtonYScal     0.5

@interface HHNewfeatureViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) UIPageControl *pageControl;
@property (weak, nonatomic) UIButton *shareButton;
@end

@implementation HHNewfeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [MBProgressHUD hideHUD];
    
    [self setupScrollView];
    
    [self setupPageControl];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //scrollView.bounds = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    
    for (int index=0; index<HHNewfeatureImageCount; index++)
    {
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", index + 1];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:name];
        imageView.frame = CGRectMake(index * imageW, 0, imageW, imageH);
        [scrollView addSubview:imageView];
        
        if (index == HHNewfeatureImageCount-1)
        {
            [self setupButtonWithImageView:imageView];
        }
    }
    scrollView.contentSize = CGSizeMake(imageW * HHNewfeatureImageCount, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;

}

- (void)setupPageControl
{
    UIPageControl *page= [[UIPageControl alloc] init];
    page.numberOfPages = HHNewfeatureImageCount;
    page.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 30);
    page.bounds = CGRectMake(0, 0, 100, 30);
    page.pageIndicatorTintColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0];
    page.currentPageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:98/255.0 blue:42/255.0 alpha:1.0];
    [self.view addSubview:page];
    self.pageControl = page;
}

- (void)setupButtonWithImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    UIButton *shareButton = [[UIButton alloc] init];
    [shareButton setTitle:@"分享给好友" forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    shareButton.center = CGPointMake(imageView.frame.size.width / 2, imageView.frame.size.height * HHNewfeatureButtonYScal);
    shareButton.bounds = CGRectMake(0, 0, 150, 30);
    shareButton.selected = YES;
    [shareButton addTarget:self action:@selector(chickShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareButton];
    self.shareButton = shareButton;
    
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startButton.center = CGPointMake(shareButton.center.x, shareButton.center.y + shareButton.frame.size.height + 10);
    startButton.bounds = CGRectMake(0, 0, startButton.currentBackgroundImage.size.width, startButton.currentBackgroundImage.size.height);
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
}

- (void)chickShareButton:(UIButton *)button
{
    button.selected = !button.selected;
    HHLog(@"%d", self.shareButton.selected);
}

- (void)start
{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[HHTabBarViewController alloc] init];
}

#pragma mark --UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    
    self.pageControl.currentPage = pageInt;
}

@end
