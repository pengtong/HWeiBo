//
//  HHTest2ViewController.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/17.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHTest2ViewController.h"
#import "HHTest3ViewController.h"

@implementation HHTest2ViewController

- (void)viewDidLoad
{
    self.title = @"Test2";
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Test3" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 200, 50, 30);
    [button addTarget:self action:@selector(chick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)chick
{
    HHTest3ViewController *test3 = [[HHTest3ViewController alloc] init];
    [self.navigationController pushViewController:test3 animated:YES];
}

@end
