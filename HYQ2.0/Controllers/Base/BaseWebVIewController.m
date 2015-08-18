//
//  BaseWebVIewController.m
//  HYQ
//
//  Created by 周翔 on 15/6/16.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "BaseWebVIewController.h"

@interface BaseWebVIewController ()

@property (nonatomic, retain) NSString  *urlStr;
@property (nonatomic, retain) NSString  *titleStr;
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) UIBarButtonItem *backBtn;
@property (nonatomic, strong) UIBarButtonItem *forwardBtn;
@property (nonatomic, strong) UIBarButtonItem *refreshBtn;
@end

@implementation BaseWebVIewController

- (id)initWithUrl:(NSString *)url andTitle:(NSString *)title
{
    if (self = [super init]) {
        _urlStr = url;
        _titleStr = title;
    }
    return self;
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    self.title = _titleStr;
    
//    _backBtn = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(webViewBack)];
//    _forwardBtn = [[UIBarButtonItem alloc] initWithTitle:@"前进" style:UIBarButtonItemStyleDone target:self action:@selector(webViewForward)];
//    _refreshBtn = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(webViewRefresh)];
//    _backBtn.enabled = _webview.canGoBack;
//    _forwardBtn.enabled = _webview.canGoForward;
//    [self.navigationController.toolbar setBarTintColor:NAVIBAR_GREEN_COLOR];
//    self.toolbarItems = @[_backBtn,_forwardBtn,_refreshBtn];
    
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49)];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    [self showWebView];
    
    UIView *toolview = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
    toolview.backgroundColor = ORANGE_COLOR;
    
    [self.view addSubview:toolview];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 49, 49);
    [backBtn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(dismissBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [toolview addSubview:backBtn];
}

- (void)showWebView
{
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    [_webview loadRequest:req];
}

- (void)dismissBtnPressed
{
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

//
//- (void)webViewBack
//{
//    [_webview goBack];
//}
//
//- (void)webViewForward
//{
//    [_webview goForward];
//}
//
//- (void)webViewRefresh
//{
//    [_webview reload];
//}

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
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

@end