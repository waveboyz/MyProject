//
//  BaseWebVIewController.m
//  HYQ
//
//  Created by 周翔 on 15/6/16.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "InfoWebViewController.h"

@interface InfoWebViewController ()

@property (nonatomic, retain) NSString  *urlStr;
@property (nonatomic, retain) NSString  *titleStr;
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) UILabel   *titleLbl;

@end

@implementation InfoWebViewController

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
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 113)];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    [self showWebView];
    
    [self.view addSubview:self.titleLbl];
    
    UIView *toolview = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
    toolview.backgroundColor = [UIColor colorWithRed:0.925 green:0.925 blue:0.925 alpha:0.5];
    [self.view addSubview:toolview];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 49, 49);
    [backBtn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(dismissBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [toolview addSubview:backBtn];
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        _titleLbl.backgroundColor = NAVIBAR_GREEN_COLOR;
        _titleLbl.font = [UIFont systemFontOfSize:13.0f];
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.text = _titleStr;
        _titleLbl.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLbl;
}

- (void)showWebView
{
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    [self showNoTextStateHud];
    [_webview loadRequest:req];
}

- (void)dismissBtnPressed
{
    [self dismissOperationExecute];
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
    [self performSelector:@selector(dismissOperationExecute) withObject:nil afterDelay:1];
}

- (void)dismissOperationExecute
{
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

@end