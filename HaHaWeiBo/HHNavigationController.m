//
//  HHNavigationController.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/17.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHNavigationController.h"
#import "UIBarButtonItem+HHBarButtonItem.h"
#import "UIImage+HHImage.h"

@implementation HHNavigationController

+(void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    //[bar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    attr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    
    NSMutableDictionary *attrEnabled = [NSMutableDictionary dictionary];
    attrEnabled[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    attrEnabled[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:attrEnabled forState:UIControlStateDisabled];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moreMore) name:@"moreMore" object:nil];
}

- (void)moreMore
{
    for (UIView *tabBarButton in self.tabBarController.tabBar.subviews)
    {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            [tabBarButton removeFromSuperview];
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"moreMore" object:nil];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back" highIcon:@"navigationbar_back_highlighted" target:self action:@selector(back)];
    
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_more" highIcon:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    
//    NSLog(@"%lu", (unsigned long)self.viewControllers.count);
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moreMore" object:nil];
    
}
@end
