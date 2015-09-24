//
//  HHTabBarViewController.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/16.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//
#import "HHTabBarViewController.h"
#import "HHMeTableViewController.h"
#import "HHHomeTableViewController.h"
#import "HHMessageTableViewController.h"
#import "HHDiscoverTableViewController.h"
#import "UIImage+HHImage.h"
#import "HHNavigationController.h"
#import "HHTabBar.h"
#import "MBProgressHUD+MJ.h"
#import "HHComposeViewController.h"
#import "CHTumblrMenuView.h"
#import "HHComposePhotoListView.h"
#import "QLAssetsModel.h"
#import "HHUserInfoTool.h"
#import "HHAccount.h"
#import "HHAccountTool.h"

@interface HHTabBarViewController () <HHTabBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) HHTabBar *customTabBar;

@property (nonatomic, strong) QLAssetsModel *assetModel;


@property (nonatomic, strong) HHHomeTableViewController *home;

@property (nonatomic, strong) HHMessageTableViewController *message;

@property (nonatomic, strong) HHDiscoverTableViewController *discover;

@property (nonatomic, strong) HHMeTableViewController *me;
@end

@implementation HHTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [MBProgressHUD hideHUD];
    
    [self setupTabBar];
    
    [self setupController];
    
    [self setupUnreadCount];
    
    NSTimer *time = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
}

- (void)setupUnreadCount
{
    HHUserUnreadCountParame *parame = [[HHUserUnreadCountParame alloc] init];
    parame.access_token = [HHAccountTool account].access_token;
    parame.uid = @([HHAccountTool account].uid);
    
    [HHUserInfoTool userUnreadCountWithParame:parame success:^(HHUserUnreadCountRelust *result)
    {
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        self.me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        
        UIApplication *app = [UIApplication sharedApplication];
        [app setAppIconBadgeNumber:result.count];
//        [UIApplication sharedApplication].applicationIconBadgeNumber = result.count;
    }
    failure:^(NSError *error)
    {
        HHLog(@"%@",error);
    }];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    for (UIView *childView in self.tabBar.subviews)
    {
        if ([childView isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
           // childView.hidden = YES;
            [childView removeFromSuperview];
        }
        
        HHLog(@"%@", childView.superclass);
    }
}

- (void) setupTabBar
{
    HHTabBar *customTabBar = [[HHTabBar alloc] init];
    customTabBar.delegate = self;
    customTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}


- (void) setupController
{
    HHHomeTableViewController *home = [[HHHomeTableViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectImageName:@"tabbar_home_selected"];
    self.home = home;
    HHMessageTableViewController *message = [[HHMessageTableViewController alloc] init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectImageName:@"tabbar_message_center_selected"];
    self.message = message;
    HHDiscoverTableViewController *discover = [[HHDiscoverTableViewController alloc] init];
    [self setupChildViewController:discover title:@"广场 " imageName:@"tabbar_discover" selectImageName:@"tabbar_discover_selected"];
    self.discover = discover;
    HHMeTableViewController *me = [[HHMeTableViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectImageName:@"tabbar_profile_selected"];
    self.me = me;
}

- (void)setupChildViewController: (UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName
{
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageWithName:imageName];
    UIImage *selectImage = [UIImage imageWithName:selectImageName];
    childVC.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    HHNavigationController *nav = [[HHNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
    
    [self.customTabBar addTabBarButtonWithTabBarItem:childVC.tabBarItem];
}
#pragma mark  --UITabBarDelegate
- (void)tabBardidSelectPlusButton
{
    __block HHComposeViewController *compose = [[HHComposeViewController alloc] init];
    HHNavigationController *nav = [[HHNavigationController alloc] initWithRootViewController:compose];
    CHTumblrMenuView *menuView = [[CHTumblrMenuView alloc] init];
    __unsafe_unretained typeof(self) weakSelf = self;
    
    [menuView addMenuItemWithTitle:@"Text" andIcon:[UIImage imageNamed:@"post_type_bubble_text.png"] andSelectedBlock:^{
        [weakSelf presentViewController:nav animated:YES completion:nil];
    }];
    
    [menuView addMenuItemWithTitle:@"Photo" andIcon:[UIImage imageNamed:@"post_type_bubble_photo.png"] andSelectedBlock:^{
        
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = weakSelf;
        [weakSelf presentViewController:ipc animated:YES completion:nil];
    }];
    
    [menuView addMenuItemWithTitle:@"Link" andIcon:[UIImage imageNamed:@"post_type_bubble_link.png"] andSelectedBlock:^{
        [weakSelf presentViewController:nav animated:YES completion:nil];
        NSLog(@"Link selected");
        
    }];
    [menuView addMenuItemWithTitle:@"Chat" andIcon:[UIImage imageNamed:@"post_type_bubble_chat.png"] andSelectedBlock:^{
        [weakSelf presentViewController:nav animated:YES completion:nil];
        NSLog(@"Chat selected");
        
    }];
    [menuView addMenuItemWithTitle:@"Video" andIcon:[UIImage imageNamed:@"post_type_bubble_video.png"] andSelectedBlock:^{
        [weakSelf presentViewController:nav animated:YES completion:nil];
        NSLog(@"Video selected");
        
    }];
    
    [menuView show];
}

- (void)tabBar:(HHTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
    
    if (to == 0)
    {
        [self.home refresh];
    }
}

#pragma mark --UIImagePickerControllerDelegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    __unsafe_unretained typeof(self) weakSelf = self;
    
    HHComposeViewController *compose = [[HHComposeViewController alloc] init];
    compose.photoImage = info[UIImagePickerControllerOriginalImage];
    HHNavigationController *nav = [[HHNavigationController alloc] initWithRootViewController:compose];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [weakSelf presentViewController:nav animated:YES completion:nil];
    }];
}

@end
