//
//  MyPaymentController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyPaymentController.h"
#import "VOSegmentedControl.h"
#import "MyPaymentHeader.h"
#import "MyPaymentCell.h"
#import "MyPaymentExpandCell.h"
#import "HYQWithdrawResponse.h"
#import "MyExtendResponse.h"

@interface MyPaymentController ()
<
    HYQWithdrawResponseDelegate,
    MyExtendResponseDelegate
>

@property (nonatomic,strong) MyPaymentHeader *header;       //头视图
@property (nonatomic,strong) VOSegmentedControl *segment;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIView *badNetView;

@end

@implementation MyPaymentController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的提成";
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

- (void)createUI
{
    [super createUI];
    [self.tableView setFrame:CGRectMake(0, 220, kScreenWidth, kScreenHeight - 220)];
    
    _header = [[MyPaymentHeader alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 180)];
    [self.view addSubview:_header];
    
    _segment = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"收益记录"},
                                                              @{VOSegmentText: @"我的推广"}]];
    _segment.frame = CGRectMake(0, 244, kScreenWidth, 40);
    _segment.contentStyle = VOContentStyleTextAlone;
    _segment.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    _segment.backgroundColor = BG_GRAY_COLOR;
    _segment.selectedBackgroundColor = _segment.backgroundColor;
    _segment.allowNoSelection = NO;
    _segment.indicatorThickness = 4;
    _segment.selectedTextColor = NAVIBAR_GREEN_COLOR;
    _segment.selectedIndicatorColor = NAVIBAR_GREEN_COLOR;
    [self.view addSubview:_segment];
    [_segment addTarget:self action:@selector(swipSegmentWithIndexPath:) forControlEvents:UIControlEventValueChanged];
    [self.tableView.header beginRefreshing];
}

- (void)getPaymentOperation
{
    [self showNoTextStateHud];
    switch (_segment.selectedSegmentIndex) {
        case 0:
        {
            HYQWithdrawResponse *response = [[HYQWithdrawResponse alloc] initWithType:@"收益记录" andWithCurrentPage:self.currentPage];
            response.delegate = self;
            [response start];
        }
            break;
            
        case 1:
        {
            MyExtendResponse *response = [[MyExtendResponse alloc] initWithCurrentPage:self.currentPage];
            response.delegate = self;
            [response start];
        }
            break;
            
        default:
            break;
    }
}

//网络错误视图
- (UIView *)badNetView
{
    if (!_badNetView) {
        _badNetView = [[UIView alloc] initWithFrame:CGRectMake(0,254 , kScreenWidth, kScreenHeight)];
        _badNetView.backgroundColor = GRAY_COLOR;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, kScreenHeight * 0.5 - 40, kScreenWidth, 80);
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(getPaymentOperation) forControlEvents:UIControlEventTouchUpInside];
        
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
    [self.dataArr removeAllObjects];
    [self.tableView.header beginRefreshing];
}

#pragma mark MyExtendResponseDelegate
- (void)getExtendArrayWith:(NSMutableArray *)exArr
{
    if (self.currentPage == 1) {
//        [self.dataArr removeAllObjects];
        self.dataArr = exArr;
    }else{
        [self.dataArr addObjectsFromArray:exArr];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        if (self.currentPage == 1) {
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
            [self.view insertSubview:self.tableView aboveSubview:self.emptyView];
            [self.view bringSubviewToFront:self.header];
            [self.view bringSubviewToFront:self.segment];
        }else{
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];
            [self.view insertSubview:self.tableView aboveSubview:self.emptyView];
            [self.view bringSubviewToFront:self.header];
            [self.view bringSubviewToFront:self.segment];
        }
    });
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
            [self.view bringSubviewToFront:self.header];
            [self.view bringSubviewToFront:self.segment];
        }else{
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];
            [self.view insertSubview:self.tableView aboveSubview:self.emptyView];
            [self.view bringSubviewToFront:self.header];
            [self.view bringSubviewToFront:self.segment];
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
    static NSString *EXPAND_CELL = @"expand_cell";
    UITableViewCell *cell;

    if (_segment.selectedSegmentIndex == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:EXPAND_CELL];
        if (!cell) {
            cell = [[MyPaymentExpandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EXPAND_CELL];
        }
        [(MyPaymentExpandCell *)cell setExpand:self.dataArr[indexPath.row]];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:PAYMENT_CELL];
        if (!cell) {
            cell = [[MyPaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PAYMENT_CELL];
        }
        [(MyPaymentCell *)cell setPayment:self.dataArr[indexPath.row]];
    }
    
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segment.selectedSegmentIndex == 1) {
        return 40.5;
    }else{
        return 60.5f;
    }
}

@end
