//
//  TradeRecordController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/28.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "TradeRecordController.h"
#import "VOSegmentedControl.h"
#import "MyPaymentCell.h"
#import "HYQWithdrawResponse.h"

@interface TradeRecordController ()
<
    HYQWithdrawResponseDelegate
>

@property (nonatomic, strong) VOSegmentedControl *segment;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIView *badNetView;

@end

@implementation TradeRecordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"交易记录";
    [self createUI];
}

- (void)loadNewData
{
    [super loadNewData];
    [self getPaymentOperation];
}

- (void)loadMoreData
{
    [super loadMoreData];
    [self getPaymentOperation];
}

- (void)getPaymentOperation
{
    [self showNoTextStateHud];
    switch (_segment.selectedSegmentIndex) {
        case 0:
        {
            HYQWithdrawResponse *response = [[HYQWithdrawResponse alloc] initWithType:@"全部" andWithCurrentPage:self.currentPage];
            response.delegate = self;
            [response start];
        }
            break;
            
        case 1:
        {
            HYQWithdrawResponse *response = [[HYQWithdrawResponse alloc] initWithType:@"购买产品" andWithCurrentPage:self.currentPage];
            response.delegate = self;
            [response start];
        }
            break;
            
        case 2:
        {
            HYQWithdrawResponse *response = [[HYQWithdrawResponse alloc] initWithType:@"提现" andWithCurrentPage:self.currentPage];
            response.delegate = self;
            [response start];
        }
            break;
            
        case 3:
        {
            HYQWithdrawResponse *response = [[HYQWithdrawResponse alloc] initWithType:@"充值" andWithCurrentPage:self.currentPage];
            response.delegate = self;
            [response start];
        }
            break;
            
        case 4:
        {
            HYQWithdrawResponse *response = [[HYQWithdrawResponse alloc] initWithType:@"提成" andWithCurrentPage:self.currentPage];
            response.delegate = self;
            [response start];
        }
            break;
            
        default:
            break;
    }
}

- (void)createUI
{
    [super createUI];
    _segment = [[VOSegmentedControl alloc] init];
    _segment.segments = @[@{VOSegmentText:@"全部"},
                          @{VOSegmentText:@"购买产品"},
                          @{VOSegmentText:@"提现"},
                          @{VOSegmentText:@"充值"},
                          @{VOSegmentText:@"提成"}];
    _segment.frame = CGRectMake(0, 64, kScreenWidth, 40);
    _segment.contentStyle = VOContentStyleTextAlone;
    _segment.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    _segment.backgroundColor = BG_GRAY_COLOR;
    _segment.selectedBackgroundColor = _segment.backgroundColor;
    _segment.allowNoSelection = NO;
    _segment.indicatorThickness = 3;
    _segment.selectedTextColor = NAVIBAR_GREEN_COLOR;
    _segment.selectedIndicatorColor = NAVIBAR_GREEN_COLOR;
    [self.view addSubview:_segment];
    [_segment addTarget:self action:@selector(swipSegmentWithIndexPath:) forControlEvents:UIControlEventValueChanged];
}

- (UIView *)badNetView
{
    if (!_badNetView) {
        _badNetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _badNetView.backgroundColor = GRAY_COLOR;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, kScreenHeight * 0.5 - 40, kScreenWidth, 80);
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
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
        [btn addTarget:self action:@selector(getPaymentOperation) forControlEvents:UIControlEventTouchUpInside];
        
        [_emptyView addSubview:btn];
    }
    
    return _emptyView;
}

- (void)swipSegmentWithIndexPath:(NSUInteger)indexpath
{
    [self.tableView.header beginRefreshing];
}

#pragma mark HYQWithdrawResponseDelegate
- (void)getInfoWith:(NSMutableArray *)infoArr
{
    if (self.currentPage == 1) {
        //        [self.dataArr removeAllObjects];
        self.dataArr = infoArr;
    }else {
        [self.dataArr addObjectsFromArray:infoArr];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        if (self.currentPage == 1) {
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
            [self.view insertSubview:self.tableView aboveSubview:self.emptyView];
        }else{
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];
            [self.view insertSubview:self.tableView aboveSubview:self.emptyView];
        }
    });


}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self showStateHudWithText:text];
    if (self.currentPage == 1) {
        [self.tableView.header endRefreshing];
    }else{
        [self.tableView.footer endRefreshing];
    }
}

- (void)noDataArr
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        [self showStateHudWithText:@"暂无更多数据~"];
        if (self.currentPage == 1) {
            //            [self.dataArr removeAllObjects];
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
            [self.view insertSubview:self.emptyView aboveSubview:self.tableView];
        }else{
            [self.tableView.footer endRefreshing];
            self.currentPage -=1;
        }
    });
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PAYMENT_CELL = @"payment_cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:PAYMENT_CELL];
        if (!cell) {
            cell = [[MyPaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PAYMENT_CELL];
        }
        [(MyPaymentCell *)cell setPayment:self.dataArr[indexPath.row]];
    
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segment.selectedSegmentIndex == 2) {
        return 40.5;
    }else{
        return 60.5f;
    }
}

@end