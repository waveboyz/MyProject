//
//  RefundController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/27.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "RefundController.h"
#import "OrderModel.h"
#import "SubOrderModel.h"
#import "CalculateRefundHeight.h"
#import "RefundFirstCell.h"
#import "RefundSecondCell.h"
#import "RefundThirdCell.h"
#import "OrderRefundResponse.h"
#import "AppDelegate.h"

@interface RefundController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    UIAlertViewDelegate,
    RefundSecondCellDelegate,
    OrderRefundResponseDelegate
>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, retain) NSMutableArray  *dataArr;
@property (nonatomic, retain) NSMutableArray *selectReasons;
@property (nonatomic, strong) OrderModel *order;

@end

@implementation RefundController

- (id)initWithSubArr:(NSArray *)arr andWithOrder:(OrderModel *)order
{
    if (self = [super init]) {
        _dataArr = [NSMutableArray new];
        _order = order;
        _selectReasons = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3"]];
        for (SubOrderModel *model in arr) {
            if ([model.status isEqualToString:@"待服务"]) {
                [_dataArr addObject:model];
            }
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 54) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(0, kScreenHeight - 54, kScreenWidth, 54);
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [confirmBtn setBackgroundColor:NAVIBAR_GREEN_COLOR];
    [confirmBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(refundPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}

- (void)refundPressed
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"你确定要申请退款吗？"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    alert.tag = 1100;
    [alert show];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1100) {
        if (buttonIndex == 1) {
            [self refundOperation];
        }
    }
}

- (void)refundOperation
{
    NSMutableString *IDStr = [NSMutableString new];
    NSMutableString *reasonStr = [NSMutableString new];
    
    for (SubOrderModel *sub in _dataArr) {
        [IDStr appendFormat:@"%@,",sub.sid];
    }

    for (NSString *str in _selectReasons) {
        [reasonStr appendFormat:@"%@,",str];
    }
    
    OrderRefundResponse *response = [[OrderRefundResponse alloc] initWithSubIDArr:IDStr
                                                                       andWithOid:_order.oid
                                                                 andWithReasonArr:reasonStr
                                                               andWithOtherReason:nil];
    response.delegate = self;
    [response start];
}

#pragma mark OrderRefundResponseDelegate
- (void)refundSucceed
{
    [self showStateHudWithText:@"申请成功"];
    [[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)refundFailedWithText:(NSString *)text
{
    [self showStateHudWithText:text];
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self showStateHudWithText:text];
}

#pragma mark RefundSecondCellDelegate
- (void)selectReasonsWith:(NSArray *)reasons
{
    [_selectReasons removeAllObjects];
    _selectReasons = [NSMutableArray arrayWithArray:reasons];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *REFUND_FIRST_CELL = @"refund_first_cell";
    static NSString *REFUND_SECOND_CELL = @"refund_second_cell";
    static NSString *REFUND_THIRD_CELL = @"refund_third_cell";
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:REFUND_FIRST_CELL];
        if (!cell) {
            cell = [[RefundFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REFUND_FIRST_CELL];
        }
        [(RefundFirstCell *)cell setDataArr:_dataArr];
    }else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:REFUND_SECOND_CELL];
        if (!cell) {
            cell = [[RefundSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REFUND_SECOND_CELL];
        }
    }else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:REFUND_THIRD_CELL];
        if (!cell) {
            cell = [[RefundThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REFUND_THIRD_CELL];
        }
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [[CalculateRefundHeight calculate] calculateHeightWithArraycount:_dataArr.count];
    }else if (indexPath.section == 1){
        return 330.0f;
    }
    
    return 240.0f;
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