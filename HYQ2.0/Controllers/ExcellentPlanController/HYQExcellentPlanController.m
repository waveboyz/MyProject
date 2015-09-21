//
//  HYQExcellentPlanController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/8/30.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQExcellentPlanController.h"
#import "HYQInterfaceMethod.h"

@interface HYQExcellentPlanController ()
<
    UIWebViewDelegate
>

@property (nonatomic, strong) UIWebView *webview;

@end

@implementation HYQExcellentPlanController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"优创计划";
    [self createUI];
}

- (void)createUI
{
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, kScreenWidth, kScreenHeight + 44)];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    [self showWebView];
}

- (void)showWebView
{
    NSURL *url = [NSURL URLWithString:EXCELLENT_PLAN_INTERFACE];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    [self showNoTextStateHud];
    [_webview loadRequest:req];
}

#pragma mark UIWebViewDeleaget
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showNoTextStateHud];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self stopStateHud];
}

@end