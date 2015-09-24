//
//  HHOAuthViewController.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/24.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHOAuthViewController.h"
#import "HHAccount.h"
#import "HHAccountTool.h"
#import "UIWindow+HH.h"
#import "MBProgressHUD+MJ.h"

@interface HHOAuthViewController ()<UIWebViewDelegate>

@end

@implementation HHOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:HHLoginUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void) accessTokenWithCode:(NSString *)code
{
    HHOAuthParame *parame = [[HHOAuthParame alloc] init];
    parame.client_id = HHAppKey;
    parame.client_secret = HHAppSecret;
    parame.grant_type = @"authorization_code";
    parame.code = code;
    parame.redirect_uri = HHRedirectUrl;
    
    [HHAccountTool oauthWitchParame:parame success:^(HHOAuthRelust *result)
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchContorller];
        [MBProgressHUD hideHUD];
    }
    failure:^(NSError *error)
    {
        [MBProgressHUD hideHUD];
        NSLog(@"请求失败%@", error);
    }];
}

#pragma mark --UIWebViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.location != NSNotFound)
    {
        NSString *code = [url substringFromIndex:range.location + range.length];
        HHLog(@"%@ ---- %@", request.URL.absoluteString, code);
        [self accessTokenWithCode:code];
        
        return NO;
    }
    
    
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MBProgressHUD hideHUD];
}

@end
