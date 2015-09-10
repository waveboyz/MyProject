//
//  ServiceDetailController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceDetailController.h"
#import "ServicePurchaseController.h"
#import "HYQUserManager.h"
#import "CatZanButton.h"
#import "CollectOperationResponse.h"
#import "ServiceIsCollectResponse.h"

@interface ServiceDetailController ()
<
    UIWebViewDelegate,
    CollectOperationResponseDelegate,
    ServiceIsCollectResponseDelegate
>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIWebView *webView;           //产品详情调用webview
@property (nonatomic, strong) UIView  *toolView;            //下方工具条
@property (nonatomic, strong) UIButton *collectBtn;         //收藏按钮
@property (nonatomic, strong) ServiceModel *service;

@end

@implementation ServiceDetailController

- (id)initWithServiceModel:(ServiceModel *)service
{
    if (self = [super init]) {
        _service = service;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    if ([[HYQUserManager sharedUserManager] isLogin]) {
        [self getServiceDetailOperation];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (void)createUI
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [self showWebView];
    
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
    _toolView.backgroundColor = [UIColor colorWithRed:0.925 green:0.925 blue:0.925 alpha:1];
    [self.view addSubview:_toolView];
    
    //购买按钮
    UIButton *purchaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    purchaseBtn.backgroundColor = NAVIBAR_GREEN_COLOR;
    purchaseBtn.frame = CGRectMake(kScreenWidth - 120, 0, 120, 49);
    [purchaseBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [purchaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [purchaseBtn addTarget:self action:@selector(purchaseBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:purchaseBtn];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeCenter;
    backBtn.frame = CGRectMake(0, 0, 49, 49);
    [backBtn addTarget:self action:@selector(dismissBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:backBtn];
    
    _collectBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 100, 0, 49, 49)];
    [_collectBtn setImage:[UIImage imageNamed:@"collect_icon"] forState:UIControlStateNormal];
    [_collectBtn addTarget:self action:@selector(collectBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:_collectBtn];
    
    //收藏label
    UILabel *collectLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 60, 0, 30, 49)];
    collectLbl.font = [UIFont systemFontOfSize:13.0f];
    collectLbl.text = @"收藏";
    collectLbl.textColor = [UIColor blackColor];
    [_toolView addSubview:collectLbl];
    
    //分享按钮
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(kScreenWidth * 0.5 - 20, 0, 29, 49);
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:shareBtn];
    
    //分享label
    UILabel *shareLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + 10, 0, 30, 49)];
    shareLbl.font = [UIFont systemFontOfSize:13.0f];
    shareLbl.text = @"分享";
    shareLbl.textColor = [UIColor blackColor];
    [_toolView addSubview:shareLbl];
}

//返回入口
- (void)dismissBtnPressed
{
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

- (void)showWebView
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",PRODUCT_DETAIL_INTERFACE,self.service.pid];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    [self showNoTextStateHud];
    [_webView loadRequest:req];
}

//购买入口
- (void)purchaseBtnPressed
{
    if ([[HYQUserManager sharedUserManager] isLogin]) {
        ServicePurchaseController *purchaseVC = [[ServicePurchaseController alloc] initWithService:_service];
        
        [self.navigationController pushViewController:purchaseVC animated:YES];
    }else{
        [self performSelectorOnMainThread:@selector(showStateHudWithText:) withObject:@"用户未登录，请先登录~" waitUntilDone:YES];
    }
}

//收藏入口
- (void)collectBtnPressed
{
    if ([[HYQUserManager sharedUserManager] isLogin]) {
        CollectOperationResponse *response = [[CollectOperationResponse alloc] initWithPid:_service.pid];
        response.delegate = self;
        [response start];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户未登录，无法收藏" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

//分享入口
- (void)shareBtnPressed
{
    [self showStateHudWithText:@"分享暂未开放~"];
}

//获取是否收藏信息
- (void)getServiceDetailOperation
{
    ServiceIsCollectResponse *response = [[ServiceIsCollectResponse alloc] initWithPid:_service.pid];
    response.delegate = self;
    [response start];
}

#pragma mark ServiceIsCollectResponseDelegate
- (void)getCollectSucceedWithIsCollected:(BOOL)isCollected
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        if (isCollected) {
            [_collectBtn setImage:[UIImage imageNamed:@"heart_collect"] forState:UIControlStateNormal];
        }else{
            [_collectBtn setImage:[UIImage imageNamed:@"collect_icon"] forState:UIControlStateNormal];
        }
    });
}

#pragma mark CollectOperationResponseDelegate
- (void)collectSucceed
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [_collectBtn setImage:[UIImage imageNamed:@"heart_collect"] forState:UIControlStateNormal];
        [self showStateHudWithText:@"收藏成功！"];
    });
}

- (void)deCollectSucceed
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [_collectBtn setImage:[UIImage imageNamed:@"collect_icon"] forState:UIControlStateNormal];
        [self showStateHudWithText:@"取消收藏成功！"];
    });
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self showStateHudWithText:text];
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showNoTextStateHud];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self stopStateHud];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self showStateHudWithText:@"网页加载失败~"];
}

@end