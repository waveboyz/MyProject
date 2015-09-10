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
@property (nonatomic, strong) UIBarButtonItem *backBtn;
@property (nonatomic, strong) UIBarButtonItem *forwardBtn;
@property (nonatomic, strong) UIBarButtonItem *refreshBtn;
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
    
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49)];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    [self showWebView];
    
    UIView *toolview = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
    toolview.backgroundColor = [UIColor colorWithRed:0.925 green:0.925 blue:0.925 alpha:0.5];
    [self.view addSubview:toolview];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 49, 49);
    [backBtn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(dismissBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [toolview addSubview:backBtn];
    
//    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    shareBtn.frame = CGRectMake(kScreenWidth - 150, 0, 29, 49);
//    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//    [toolview addSubview:shareBtn];
//    
//    UILabel *shareLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 115, 0, 30, 49)];
//    shareLbl.font = [UIFont systemFontOfSize:13.0f];
//    shareLbl.textColor = [UIColor blackColor];
//    shareLbl.text = @"分享";
//    [toolview addSubview:shareLbl];
//    
//    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    commentBtn.frame = CGRectMake(kScreenWidth - 75, 1, 29, 48);
//    [commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
//    [toolview addSubview:commentBtn];
//    
//    UILabel *countLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 0, 30, 49)];
//    countLbl.font = [UIFont systemFontOfSize:13.0f];
//    countLbl.textColor = [UIColor blackColor];
//    countLbl.text = @"20";
//    [toolview addSubview:countLbl];
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
    [self performSelector:@selector(dismissOperationExecute) withObject:nil afterDelay:1];
}

- (void)dismissOperationExecute
{
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

@end