//
//  MyorderFormController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyorderFormController.h"
#import "MyOrderEvaluateController.h"
#import "ServicePurchaseController.h"
#import "VOSegmentedControl.h"
#import "MyOrderFormCell.h"
#import "MyOrderResponse.h"

@interface MyorderFormController ()
<
    MyOrderResponseDelegate,
    MyOrderFormCellDelegate
>

@property (nonatomic,strong) VOSegmentedControl *segment;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIView *badNetView;

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
    
    [self.view insertSubview:self.badNetView belowSubview:self.segment];
}

- (void)noDataArr
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
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
    }
    [(MyOrderFormCell *)cell setOrder:self.dataArr[indexPath.row]];
    [(MyOrderFormCell *)cell setDelegate:self];
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
}

#pragma mark MyOrderFormCellDelegate
- (void)payBtnPressedWithOid:(NSNumber *)oid andWithIndexPath:(NSIndexPath *)indexPath
{

}

- (void)evaluateBtnPressedWithOid:(NSNumber *)oid andWithIndexPath:(NSIndexPath *)indexPath
{
    OrderModel *model = self.dataArr[indexPath.row];
    MyOrderEvaluateController *evaluateVC = [[MyOrderEvaluateController alloc] initWithOid:model.oid];
    [self.navigationController pushViewController:evaluateVC animated:YES];
}

- (void)confirmBtnPressedWithOid:(NSNumber *)oid andWithIndexPath:(NSIndexPath *)indexPath
{

}

@end