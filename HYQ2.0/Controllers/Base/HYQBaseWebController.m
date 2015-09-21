//
//  HYQBaseWebController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQBaseWebController.h"

@interface HYQBaseWebController ()
<
    UIWebViewDelegate
>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *titleStr;

@end

@implementation HYQBaseWebController

- (id)initWithUrl:(NSString *)url andWithTitle:(NSString *)title;
{
    if (self = [super init]) {
        _url = url;
        _titleStr = title;
    }
    
    return self;
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    [self createUI];
}

- (void)createUI
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, kScreenWidth, kScreenHeight+44)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [self showWebView];
}

- (void)showWebView
{
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    [self showNoTextStateHud];
    [_webView loadRequest:req];
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showNoTextStateHud];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.stateHud.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self showStateHudWithText:@"网页加载失败~"];
}

@end