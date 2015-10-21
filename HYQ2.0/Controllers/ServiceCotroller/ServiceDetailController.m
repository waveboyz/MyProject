//
//  ServiceDetailController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceDetailController.h"
#import "ServicePurchaseController.h"
#import "HYQLoginController.h"
#import "HYQUserManager.h"
#import "CollectOperationResponse.h"
#import "ServiceIsCollectResponse.h"
#import "UMSocial.h"
#import "UIImageView+WebCache.h"
#import "ProductModel.h"
#import "EvaluateModel.h"
#import "PurchaseDetailImageCell.h"
#import "PurchaseDetailSelectCell.h"
#import "PurchaseQualityCell.h"
#import "PurchaseDetailCell.h"
#import "CalculateHeight.h"

@interface ServiceDetailController ()
<
    UIWebViewDelegate,
    UMSocialUIDelegate,
    CollectOperationResponseDelegate,
    ServiceIsCollectResponseDelegate
>

@property (nonatomic, strong) UITableView *tableview;
//@property (nonatomic, strong) UIWebView *webView;           //产品详情调用webview
@property (nonatomic, strong) UIView  *toolView;            //下方工具条
@property (nonatomic, strong) UIButton *collectBtn;         //收藏按钮
@property (nonatomic, strong) ServiceModel *service;
@property (nonatomic, strong) OrderModel *order;
@property (nonatomic, strong) ProductModel *product;
@property (nonatomic, strong) EvaluateModel *evaluate;

@end

@implementation ServiceDetailController

- (id)initWithServiceModel:(ServiceModel *)service
{
    if (self = [super init]) {
        _service = service;
    }

    return self;
}

- (id)initWithOrderModel:(OrderModel *)order
{
    if (self = [super init]) {
        _order = order;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    [self getServiceDetailOperation];
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
//    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    _webView.delegate = self;
//    [self.view addSubview:_webView];
//    [self showWebView];
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.backgroundColor = BG_GRAY_COLOR;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];
    
    [self.view addSubview:self.toolView];
}

- (UIView *)toolView
{
    if (!_toolView) {
        _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
        _toolView.backgroundColor = [UIColor colorWithRed:0.925 green:0.925 blue:0.925 alpha:1];
        
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
    
    return _toolView;
}

//返回入口
- (void)dismissBtnPressed
{
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

//- (void)showWebView
//{
//    NSString *urlStr;
//    if (_order) {
//        urlStr = [NSString stringWithFormat:@"%@%@",PRODUCT_DETAIL_INTERFACE,self.order.pid];
//    }else if (_service){
//        urlStr = [NSString stringWithFormat:@"%@%@",PRODUCT_DETAIL_INTERFACE,self.service.pid];
//    }
//
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
//    [self showNoTextStateHud];
//    [_webView loadRequest:req];
//}

//购买入口
- (void)purchaseBtnPressed
{
    ServicePurchaseController *purchaseVC = [[ServicePurchaseController alloc] init];
    [self.navigationController pushViewController:purchaseVC animated:YES];
}

//收藏入口
- (void)collectBtnPressed
{
    CollectOperationResponse *response;
    if (_order) {
        response = [[CollectOperationResponse alloc] initWithPid:_order.pid];
    }else if (_service){
        response = [[CollectOperationResponse alloc] initWithPid:_service.pid];
    }

    response.delegate = self;
    [response start];
}

//分享入口
- (void)shareBtnPressed
{
    NSString *webUrl = [NSString new];
    if (_order) {
        webUrl = [NSString stringWithFormat:@"%@%@",PRODUCT_DETAIL_INTERFACE,self.order.pid];
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:UME_APPKEY
                                          shareText:_order.name
                                         shareImage:[UIImage imageNamed:@"appIcon"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToWechatSession,nil]
                                           delegate:self];
    }else if (_service){
        webUrl = [NSString stringWithFormat:@"%@%@",PRODUCT_DETAIL_INTERFACE,self.service.pid];
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:UME_APPKEY
                                          shareText:_service.title
                                         shareImage:[UIImage imageNamed:@"appIcon"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToWechatSession,nil]
                                           delegate:self];
    }
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = webUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = webUrl;
    [UMSocialData defaultData].extConfig.qqData.url = webUrl;
    [UMSocialData defaultData].extConfig.qzoneData.url = webUrl;
}

//获取是否收藏信息
- (void)getServiceDetailOperation
{
    [self showNoTextStateHud];
    ServiceIsCollectResponse *response;
    if (_service) {
        response = [[ServiceIsCollectResponse alloc] initWithPid:_service.pid];
    }else if (_order){
        response = [[ServiceIsCollectResponse alloc] initWithPid:_order.pid];
    }

    response.delegate = self;
    [response start];
}

#pragma mark ServiceIsCollectResponseDelegate
- (void)getCollectSucceedWithIsCollected:(BOOL)isCollected andWith:(ProductModel *)product andWith:(EvaluateModel *)evaluate
{
    [self stopStateHud];
    _product = product;
    _evaluate = evaluate;
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self.tableview reloadData];
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
    [self stopStateHud];
    [self showStateHudWithText:text];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *IMAGE_CELL = @"image_cell";
    static NSString *SELECT_CELL = @"select_cell";
    static NSString *EVALUATE_CELL = @"evaluate_cell";
    static NSString *DETAIL_CELL = @"detail_cell";

    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:IMAGE_CELL];
        if (!cell) {
            cell = [[PurchaseDetailImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IMAGE_CELL];
        }
        [(PurchaseDetailImageCell *)cell setProduct:self.product];
    }else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:SELECT_CELL];
        if (!cell) {
            cell = [[PurchaseDetailSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SELECT_CELL];
        }
    }else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:EVALUATE_CELL];
        if (!cell) {
            cell = [[PurchaseQualityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EVALUATE_CELL];
        }
        [(PurchaseQualityCell *)cell setEvaluate:self.evaluate];
    }else if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:DETAIL_CELL];
        if (!cell) {
            cell = [[PurchaseDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DETAIL_CELL];
        }
        [(PurchaseDetailCell *)cell setProduct:self.product];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 390.0f;
    }else if (indexPath.section == 1){
        return 55.0f;
    }else if (indexPath.section == 2){
        return 130.0f;
    }else if (indexPath.section == 3){
        CGFloat height = [[CalculateHeight calculate] calculateHeightWithString:_product.contentText];
        
        return 85 + height;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    blankView.backgroundColor = BG_GRAY_COLOR;
    return blankView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40.0f;
}

//#pragma mark UIWebViewDelegate
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//    [self showNoTextStateHud];
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [self stopStateHud];
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    [self showStateHudWithText:@"网页加载失败~"];
//}

@end