//
//  MyorderFormController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyorderFormController.h"
#import "MyOrderEvaluateController.h"
#import "MyOrderDetailController.h"
#import "ServiceDetailController.h"
#import "VOSegmentedControl.h"
#import "MyOrderFormCell.h"
#import "OrderModel.h"
#import "Order.h"
#import "DataSigner.h"
#import "DownSheet.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MyOrderResponse.h"
#import "AliPayCallBackResponse.h"
#import "MyOrderDeleteResponse.h"

@interface MyorderFormController ()
<
    MyOrderResponseDelegate,
    MyOrderFormCellDelegate,
    DownSheetDelegate,
    AliPayCallBackResponseDelegate,
    MyOrderDeleteResponseDelegate,
    MyOrderEvaluateControllerDelegate
>

@property (nonatomic,strong) VOSegmentedControl *segment;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIView *badNetView;
@property (nonatomic, retain) NSArray           *sheetArr;      //支付方式数组
@property (nonatomic, retain) NSIndexPath       *pressedIndex;

@end

@implementation MyorderFormController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    [self createUI];
}

- (void)loadNewData
{
    [super loadNewData];
    [self getOrderOperation];
}

- (void)loadMoreData
{
    [super loadMoreData];
    [self getOrderOperation];
}

- (void)createUI
{
    [super createUI];
    self.tableView.frame = CGRectMake(0, 40, kScreenWidth, kScreenHeight - 40);
    
    _segment = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText:@"全部"},
                                                              @{VOSegmentText:@"待付款"},
                                                              @{VOSegmentText:@"待服务"},
                                                              @{VOSegmentText:@"待评价"}]];
    _segment.frame = CGRectMake(0, 64, kScreenWidth, 40);
    _segment.contentStyle = VOContentStyleTextAlone;
    _segment.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    _segment.backgroundColor = BG_GRAY_COLOR;
    _segment.selectedBackgroundColor = _segment.backgroundColor;
    _segment.allowNoSelection = NO;
    _segment.indicatorThickness = 4;
    _segment.selectedTextColor = NAVIBAR_GREEN_COLOR;
    _segment.selectedIndicatorColor = NAVIBAR_GREEN_COLOR;
    [self.view addSubview:_segment];
    self.tableView.backgroundColor = GRAY_COLOR;
    [_segment addTarget:self action:@selector(swipSegmentWithIndexPath:) forControlEvents:UIControlEventValueChanged];
    [self.tableView.header beginRefreshing];
}

//actionsheet列表
- (NSArray *)sheetArr
{
    if (!_sheetArr) {
        DownSheetModel *Model_1 = [[DownSheetModel alloc]init];
        Model_1.title = @"选择使用支付宝";
        Model_1.icon = @"aliIcon";
        DownSheetModel *Model_2 = [[DownSheetModel alloc]init];
        Model_2.title = @"取消";
        
        _sheetArr = [NSArray arrayWithObjects:Model_1,Model_2, nil];
    }
    
    return _sheetArr;
}

//获取订单列表请求
- (void)getOrderOperation
{
    [self showNoTextStateHud];
    NSString *type;
    switch (_segment.selectedSegmentIndex) {
        case 0:
        {
            type = @"全部";
        }
            break;
        case 1:
        {
            type = @"待付款";
        }
            break;
        case 2:
        {
            type = @"待服务";
        }
            break;
            
        case 3:
        {
            type = @"待评价";
        }
            break;
            
        default:
            break;
    }
    MyOrderResponse *response = [[MyOrderResponse alloc] initWithTypeNanme:type andWithCurrentPage:self.currentPage];
    response.delegate = self;
    [response start];
}

- (void)swipSegmentWithIndexPath:(NSUInteger)indexpath
{
    [self.tableView.header beginRefreshing];
}

//加载错误视图
- (UIView *)badNetView
{
    if (!_badNetView) {
        _badNetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _badNetView.backgroundColor = GRAY_COLOR;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, kScreenHeight * 0.5 - 40, kScreenWidth, 80);
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(getOrderOperation) forControlEvents:UIControlEventTouchUpInside];

        [_badNetView addSubview:btn];
    }
    
    return _badNetView;
}

- (UIView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _emptyView.backgroundColor = GRAY_COLOR;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, kScreenHeight * 0.5 - 40, kScreenWidth, 80);
        [btn setTitle:@"暂无记录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(getOrderOperation) forControlEvents:UIControlEventTouchUpInside];
        
        [_emptyView addSubview:btn];
    }
    
    return _emptyView;
}

- (void)payOperation
{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    OrderModel *data = self.dataArr[_pressedIndex.section];
    Order *order = [[Order alloc] init];
    order.partner = PARTNER;
    order.seller = SELLER;
    order.tradeNO = [data.orderNum stringValue]; //订单ID（由商家自行制定）
    order.productName = data.name; //商品标题
    order.productDescription = data.proSummery; //商品描述
//    float price = [data.money floatValue]* [data.num integerValue];
//    order.amount = [NSString stringWithFormat:@"%f",price];
    order.amount = @"0.01";
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"HYQ2.0";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    NSString *privateKey = PRIVATEKEY;
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            [self payStatusWithDic:resultDic];
            
        }];
    }
}

//支付宝支付结果返回
- (void)payStatusWithDic:(NSDictionary *)dic
{
    NSNumber *state = [dic objectForKey:@"resultStatus"];
    
    OrderModel *data = self.dataArr[_pressedIndex.section];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *numTemp = [numberFormatter numberFromString:[data.orderNum stringValue]];
    
    AliPayCallBackResponse *response = [[AliPayCallBackResponse alloc] initWithTradeNO:numTemp andWithTradeStatus:state andWithResult:[dic objectForKey:@"result"]];
    response.delegate = self;
    [response start];
}



- (void)noDataArr
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        [self showStateHudWithText:@"没有更多数据~"];
        if (self.currentPage == 1) {
            [self.tableView.header endRefreshing];
            [self.view insertSubview:self.emptyView belowSubview:self.segment];
        }else{
            [self.tableView.footer endRefreshing];
            self.currentPage -=1;
        }
    });
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ORDER_CELL = @"order_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ORDER_CELL];
    if (!cell) {
        cell = [[MyOrderFormCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ORDER_CELL];
        [(MyOrderFormCell *)cell setDelegate:self];
    }
    [(MyOrderFormCell *)cell setOrder:self.dataArr[indexPath.section]];
    [(MyOrderFormCell *)cell setIndexPath:indexPath];
    
    return cell;
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 134.5f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//    OrderModel *order = self.dataArr[indexPath.section];
//    if (![order.statusMsg isEqualToString:@"待付款"] && order.statusMsg) {
//        MyOrderDetailController *detailVC = [[MyOrderDetailController alloc] initWithOrder:order];
//        [self.navigationController pushViewController:detailVC animated:YES];
//    }
}

#pragma mark MyOrderFormCellDelegate
- (void)payBtnPressedWithOid:(NSNumber *)oid andWithIndexPath:(NSIndexPath *)indexPath
{
    _pressedIndex = nil;
    _pressedIndex = indexPath;
    DownSheet *sheet = [[DownSheet alloc]initWithlist:self.sheetArr height:0];
    sheet.delegate = self;
    [sheet showInView:self];
}

- (void)evaluateBtnPressedWithOid:(NSNumber *)oid andWithIndexPath:(NSIndexPath *)indexPath
{
    _pressedIndex = nil;
    _pressedIndex = indexPath;
    OrderModel *model = self.dataArr[indexPath.row];
    MyOrderEvaluateController *evaluateVC = [[MyOrderEvaluateController alloc] initWithOid:model.oid andWithSettleID:model.settlementId];
    evaluateVC.delegate = self;
    [self.navigationController pushViewController:evaluateVC animated:YES];
}

- (void)confirmBtnPressedWithOid:(NSNumber *)oid andWithIndexPath:(NSIndexPath *)indexPath
{
    _pressedIndex = nil;
}

- (void)deleteBtnPressedWithOid:(NSNumber *)oid andWithIndexPath:(NSIndexPath *)indexPath
{
    _pressedIndex = nil;
    _pressedIndex = indexPath;
    OrderModel *model = self.dataArr[indexPath.row];
    [self showNoTextStateHud];
    MyOrderDeleteResponse *response = [[MyOrderDeleteResponse alloc] initWithOid:[model.oid integerValue] andWithPayID:model.orderNum];
    response.delegate = self;
    [response start];
}

- (void)purchaseBtnPressedWithOid:(NSNumber *)oid andWithIndexPath:(NSIndexPath *)indexPath
{
    _pressedIndex = nil;
    OrderModel *model = self.dataArr[indexPath.row];
    ServiceDetailController *serviceVC = [[ServiceDetailController alloc] initWithOrderModel:model];
    serviceVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UINavigationController * jackNavigationController = [[UINavigationController alloc] initWithRootViewController:serviceVC];
    [self presentViewController:jackNavigationController animated:YES completion:^(void){}]; 
}

#pragma mark MyOrderDeleteResponseDelegate
- (void)deleteSucceed
{
    [self stopStateHud];
    [self.dataArr removeObjectAtIndex:_pressedIndex.row];
    [self.tableView reloadData];
}

#pragma mark MyOrderResponseDelegate
- (void)getOrderListWithArray:(NSMutableArray *)orderArr
{
    if (self.currentPage == 1) {
        [self.dataArr removeAllObjects];
        self.dataArr = orderArr;
    }else{
        [self.dataArr addObjectsFromArray:orderArr];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        if (self.currentPage == 1) {
            [self.tableView.header endRefreshing];
        }else{
            [self.tableView.footer endRefreshing];
        }
        [self.tableView reloadData];
        [self.view insertSubview:self.tableView belowSubview:self.segment];
    });
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self showStateHudWithText:text];
    [self.tableView.header endRefreshing];
}

#pragma mark DownSheetDelegate
-(void)didSelectIndex:(NSInteger)index
{
    if (index == 0) {
        [self payOperation];
    }
}

#pragma mark AliPayCallBackResponseDelegate
- (void)getPayResult
{
    [self stopStateHud];
    [self.tableView.header beginRefreshing];
}

#pragma mark MyOrderEvaluateControllerDelegate
- (void)evaluateSucceed
{
    [self.dataArr removeAllObjects];
    [self.tableView.header beginRefreshing];
}

@end