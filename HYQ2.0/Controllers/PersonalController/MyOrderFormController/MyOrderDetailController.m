//
//  MyOrderDetailController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/23.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyOrderDetailController.h"
#import "MyOrderDetailResponse.h"
#import "OrderInfoModel.h"
#import "OrderDetailCell.h"
#import "OrderInfoCell.h"
#import "SubOrderCell.h"
#import "OrderModel.h"
#import "CalculateSubOrderHeight.h"
#import "RefundController.h"
#import "ServiceDetailController.h"

@interface MyOrderDetailController ()
<
    MyOrderDetailResponseDelegate,
    OrderDetailCellDelegate,
    UIAlertViewDelegate
>

@property (nonatomic, retain) OrderModel *order;
@property (nonatomic, retain) OrderInfoModel *infoData;

@end

@implementation MyOrderDetailController

- (id)initWithOrder:(OrderModel *)order
{
    if (self = [super init]) {
        _order = order;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getOrderdetailOperation];
    self.title = @"订单详情";
}

- (void)loadNewData
{
    [self getOrderdetailOperation];
}

- (void)getOrderdetailOperation
{
    [self showNoTextStateHud];
    MyOrderDetailResponse *response = [[MyOrderDetailResponse alloc] initWithOid:_order.oid];
    response.delegate = self;
    [response start];
}

- (void)createUI
{
    [super createUI];
    self.tableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
    self.tableView.footer.hidden = YES;
    self.tableView.backgroundColor = BG_GRAY_COLOR;
}

#pragma mark MyOrderDetailResponseDelegate
- (void)getInfoSucceedWith:(OrderInfoModel *)info andWith:(NSArray *)subArr
{
    [self stopStateHud];
    [self.dataArr removeAllObjects];
    self.infoData = nil;
    _infoData = info;
    self.dataArr = [NSMutableArray arrayWithArray:subArr];
    [self createUI];
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self showStateHudWithText:text];
}

#pragma mark OrderDetailCellDelegate
- (void)refundBtnTouched
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"你是否要申请退款？(已服务订单不予退款)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1005;
    [alert show];
}

- (void)purchaseBtnTouched
{
    ServiceDetailController *serVC = [[ServiceDetailController alloc] initWithOrderModel:_order];
    serVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UINavigationController * jackNavigationController = [[UINavigationController alloc] initWithRootViewController:serVC];
    [self presentViewController:jackNavigationController animated:YES completion:^(void){}];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1005) {
        if (buttonIndex == 1) {
            [self showRefundView];
        }
    }
}

- (void)showRefundView
{
    RefundController *refundVC = [[RefundController alloc] initWithSubArr:self.dataArr andWithOrder:_order];
    [self.navigationController pushViewController:refundVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ORDER_DETAIL_CELL = @"order_detail_cell";
    static NSString *SUB_ORDER_CELL = @"sub_order_cell";
    static NSString *ORDER_INFO_CELL = @"order_info_cell";
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:ORDER_DETAIL_CELL];
        if (!cell) {
            cell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ORDER_DETAIL_CELL];
        }
        [(OrderDetailCell *)cell setOrder:_order];
        [(OrderDetailCell *)cell setDelegate:self];
    }else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:SUB_ORDER_CELL];
        if (!cell) {
            cell = [[SubOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SUB_ORDER_CELL];
        }
        [(SubOrderCell *)cell setDataArr:self.dataArr];
    }else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:ORDER_INFO_CELL];
        if (!cell) {
            cell = [[OrderInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ORDER_INFO_CELL];
        }
        [(OrderInfoCell *)cell setInfo:_infoData];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 114.5f;
    }else if (indexPath.section == 1){
        return [[CalculateSubOrderHeight calculate] calculateHeightWithArraycount:self.dataArr.count];
    }else if (indexPath.section == 2){
        return 165.0f;
    }
    
    return 40.0f;
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section != 2) {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        footer.backgroundColor = BG_GRAY_COLOR;
        
        return footer;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section != 2) {
        return 20.0f;
    }
    
    return 0;
}

@end