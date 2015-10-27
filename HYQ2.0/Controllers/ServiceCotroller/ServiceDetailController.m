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
#import "MyAddressPickController.h"
#import "HYQUserManager.h"
#import "CollectOperationResponse.h"
#import "ServiceIsCollectResponse.h"
#import "UMSocial.h"
#import "UIImageView+WebCache.h"
#import "ProductModel.h"
#import "EvaluateModel.h"
#import "ProductTypeModel.h"
#import "ProductComboModel.h"
#import "DistrictModel.h"
#import "PurchaseDetailImageCell.h"
#import "PurchaseDetailSelectCell.h"
#import "PurchaseQualityCell.h"
#import "PurchaseDetailCell.h"
#import "CalculateHeight.h"
#import "ServiceSelectionView.h"


@interface ServiceDetailController ()
<
    UMSocialUIDelegate,
    CollectOperationResponseDelegate,
    ServiceIsCollectResponseDelegate,
    ServiceSelectionViewDelegate
>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) ServiceSelectionView *selectView;
@property (nonatomic, strong) UIView  *toolView;            //下方工具条
@property (nonatomic, strong) UIButton *collectBtn;         //收藏按钮
@property (nonatomic, strong) ServiceModel *service;    //产品列表模型
@property (nonatomic, strong) OrderModel *order;        //订单模型
@property (nonatomic, strong) ProductModel *product;    //产品详情模型
@property (nonatomic, strong) EvaluateModel *evaluate;  //评价模型
@property (nonatomic, strong) DistrictModel *selectDis; //已选择地址模型
@property (nonatomic, strong) ProductTypeModel *selectType; //已选择type
@property (nonatomic, retain) NSMutableArray *selectCombos;//已选择套餐
@property (nonatomic, retain) UIView        *shadowView; //阴影图片

@end

@implementation ServiceDetailController

- (id)initWithServiceModel:(ServiceModel *)service
{
    if (self = [super init]) {
        _service = service;
        _selectCombos = [NSMutableArray new];
    }

    return self;
}

- (id)initWithOrderModel:(OrderModel *)order
{
    if (self = [super init]) {
        _order = order;
        _selectCombos = [NSMutableArray new];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    [self getServiceDetailOperation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDistrictController) name:@"pickDistrict" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadSelectView:) name:@"finishedAddPick" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pickDistrict" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pickDistrict" object:nil];
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

//购买入口
- (void)purchaseBtnPressed
{
    if (!_selectDis) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未选择地址" message:@"请在选择服务类型中选择服务地址！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
    }else{
        ServicePurchaseController *purchaseVC = [[ServicePurchaseController alloc] initWithProduct:_product andWithType:_selectType andWithComboArr:_selectCombos andWithDistrict:_selectDis];
        [self.navigationController pushViewController:purchaseVC animated:YES];
    }
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
    UIImageView *sharedImg = [[UIImageView alloc] init];
    NSString *imgUrl = [NSString new];
    imgUrl = [NSString stringWithFormat:@"%@%@",LOCAL_HOST,self.product.photo];
    [sharedImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"product_placeholder"]];

    NSString *webUrl = [NSString new];
    webUrl = [NSString stringWithFormat:@"%@%@",PRODUCT_DETAIL_INTERFACE,self.product.pid];
    [UMSocialSnsService presentSnsIconSheetView:self
                                            appKey:UME_APPKEY
                                        shareText:_product.contentText
                                        shareImage:sharedImg.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToWechatSession,nil]
                                        delegate:self];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = webUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = webUrl;
    [UMSocialData defaultData].extConfig.qqData.url = webUrl;
    [UMSocialData defaultData].extConfig.qzoneData.url = webUrl;
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = _product.name;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = _product.name;
    [UMSocialData defaultData].extConfig.qqData.title = _product.name;
    [UMSocialData defaultData].extConfig.qzoneData.title = _product.name;
}

//获取是否收藏信息
- (void)getServiceDetailOperation
{
    [self showNoTextStateHud];
    ServiceIsCollectResponse *response;
    if (_service) {
        response = [[ServiceIsCollectResponse alloc] initWithPid:_service.pid andWithPTID:_service.ptid];
    }else if (_order){
        response = [[ServiceIsCollectResponse alloc] initWithPid:_order.pid andWithPTID:nil];
    }

    response.delegate = self;
    [response start];
}

- (void)showSelectViewOperation
{
    _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    _shadowView.backgroundColor = [UIColor blackColor];
    _shadowView.alpha = 0;
    [self.view addSubview:_shadowView];
    
    [UIView animateWithDuration:0.5 animations:^(void){
        CGRect rect = _selectView.frame;
        rect.origin.y -=kScreenHeight - 120;
        [_selectView setFrame:rect];
    } completion:^(BOOL finished){
        _shadowView.alpha = 0.8;
    }];
}

#pragma mark ServiceIsCollectResponseDelegate
- (void)getCollectSucceedWithIsCollected:(BOOL)isCollected
                                 andWith:(ProductModel *)product
                                 andWith:(EvaluateModel *)evaluate
                                 andwith:(NSMutableArray *)typeArr
{
    [self stopStateHud];
    _product = product;
    _evaluate = evaluate;
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        _selectView = [[ServiceSelectionView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight - 120)
                                                   andWithProduct:_product
                                                   andWithTypeArr:typeArr];
        _selectView.delegate = self;
        [self.view addSubview:_selectView];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *IMAGE_CELL = @"image_cell";
    static NSString *SELECT_CELL = @"select_cell";
    static NSString *EVALUATE_CELL = @"evaluate_cell";
    static NSString *DETAIL_CELL = @"detail_cell";

    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:IMAGE_CELL];
        if (!cell) {
            cell = [[PurchaseDetailImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IMAGE_CELL];
        }
        [(PurchaseDetailImageCell *)cell setProduct:self.product];
    }else if (indexPath.row == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:SELECT_CELL];
        if (!cell) {
            cell = [[PurchaseDetailSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SELECT_CELL];
        }
        [(PurchaseDetailSelectCell *)cell setType:_selectType];
        [(PurchaseDetailSelectCell *)cell setComboArr:_selectCombos];
    }else if (indexPath.row == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:EVALUATE_CELL];
        if (!cell) {
            cell = [[PurchaseQualityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EVALUATE_CELL];
        }
        [(PurchaseQualityCell *)cell setEvaluate:self.evaluate];
    }else if (indexPath.row == 3){
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
    if (indexPath.row == 0) {
        return 355.0f;
    }else if (indexPath.row == 1){
        return 95.0f;
    }else if (indexPath.row == 2){
        return 170.0f;
    }else if (indexPath.row == 3){
        CGFloat height = [[CalculateHeight calculate] calculateHeightWithString:_product.contentText];
        
        return 75 + height;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self showSelectViewOperation];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark ServiceSelectionViewDelegate
- (void)finishedPickWithType:(ProductTypeModel *)type
             andWithDistrict:(DistrictModel *)district
             andWithComboArr:(NSMutableArray *)comboArr
{
    _selectType = nil;
    _selectDis = nil;
    [_selectCombos removeAllObjects];
    
    _selectType = type;
    _selectDis = district;
    _selectCombos = comboArr;
    [self hideSelectionViewOperation];
    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

//确认后隐藏选择页
- (void)hideSelectionViewOperation
{
    [UIView animateWithDuration:0.5 animations:^(void){
        CGRect rect = _selectView.frame;
        rect.origin.y +=kScreenHeight - 120;
        _selectView.frame = rect;
        _shadowView.alpha = 0;
        [_shadowView removeFromSuperview];
        _shadowView = nil;
    }];
}

//显示地区选择
- (void)showDistrictController
{
    MyAddressPickController *addVC = [[MyAddressPickController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}

//刷新SelectView
- (void)reloadSelectView:(NSNotification *)aNotification
{
    id unknown = [aNotification object];
    if ([unknown isKindOfClass:[DistrictModel class]]) {
        _selectDis = (DistrictModel *)unknown;
        [self.selectView reloadAddressCellWith:(DistrictModel *)unknown];
    }
}
@end