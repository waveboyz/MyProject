//
//  RefundScheduleController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/28.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "RefundScheduleController.h"
#import "RefundScheDuleCell.h"
#import "RefundScheduleSecondCell.h"
#import "RefundScheduleThirdCell.h"
#import "CalculateSubOrderHeight.h"
#import "RefundScheduleResponse.h"
#import "OrderModel.h"
#import "OrderInfoModel.h"
#import "RefundScheduleModel.h"


@interface RefundScheduleController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    RefundScheduleResponseDelegate
>
@property (nonatomic, assign) OrderModel *order;        //push的订单列表页模型
@property (nonatomic, assign) OrderInfoModel *orderInfo;     //订单详情页模型
@property (nonatomic, retain) RefundScheduleModel *schedule;
@property (nonatomic, retain) NSMutableArray *subArr;
@property (nonatomic, retain) UITableView *tableview;

@end

@implementation RefundScheduleController

- (id)initWithOrder:(OrderModel *)order
{
    if (self = [super init]) {
        _order = order;
        _subArr = [NSMutableArray new];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"退款进度";
    [self getRefundScheduleOperation];
}

- (void)createUI
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.backgroundColor = BG_GRAY_COLOR;
    [self.view addSubview:_tableview];
}

- (void)getRefundScheduleOperation
{
    [self showNoTextStateHud];
    RefundScheduleResponse *response = [[RefundScheduleResponse alloc] initWithOid:_order.oid];
    response.delegate = self;
    [response start];
}

#pragma mark RefundScheduleResponseDelegate
- (void)getScheduleWith:(OrderModel *)order andWithSubArr:(NSArray *)subArr andWithScheDuel:(RefundScheduleModel *)schedule
{
    [self stopStateHud];
    _subArr = [[NSMutableArray alloc] initWithArray:subArr];
    _schedule = schedule;
    [self createUI];
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
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
    static NSString *SCHEDUAL_FIRST_CELL = @"schedual_first_cell";
    static NSString *SCHEDUAL_SECOND_CELL = @"schedual_second_cell";
    static NSString *SCHEDUAL_THIRD_CELL = @"schedual_third_cell";
    
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:SCHEDUAL_FIRST_CELL];
        if (!cell) {
            cell = [[RefundScheDuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SCHEDUAL_FIRST_CELL];
        }
        [(RefundScheDuleCell *)cell setOrder:_order];
    }else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:SCHEDUAL_SECOND_CELL];
        if (!cell) {
            cell = [[RefundScheduleSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SCHEDUAL_SECOND_CELL];
        }
        [(RefundScheduleSecondCell *)cell setSubArr:_subArr];
    }else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:SCHEDUAL_THIRD_CELL];
        if (!cell) {
            cell = [[RefundScheduleThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SCHEDUAL_THIRD_CELL];
        }
        [(RefundScheduleThirdCell *)cell setRefundSchedule:_schedule];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 114.5f;
    }else if (indexPath.section == 1){
        return [[CalculateSubOrderHeight calculate] calculateHeightWithArraycount:_subArr.count] - 20;
    }else if (indexPath.section == 2){
        return 260.0f;
    }
    
    return 0;
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
