//
//  MYDiscountController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MYDiscountController.h"
#import "VOSegmentedControl.h"
#import "MyDiscountCell.h"
#import "MyDiscountResponse.h"

@interface MYDiscountController ()
<
    MyDiscountResponseDelete
>

@property (nonatomic,strong) VOSegmentedControl *segment;
@property (nonatomic, strong) UIView *emptyView;

@end

@implementation MYDiscountController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的优惠券";
    self.view.backgroundColor = BG_GRAY_COLOR;
    [self createUI];
}

- (void)loadNewData
{
    [super loadNewData];
    
    [self getDiscountOperation];
}

- (void)loadMoreData
{
    [super loadMoreData];
    [self getDiscountOperation];
}

- (void)getDiscountOperation
{
    [self showNoTextStateHud];
    NSString *type;
    switch (_segment.selectedSegmentIndex) {
        case 0:
        {
            type = @"可用优惠券";
        }
            break;
            
        case 1:
        {
        type = @"历史优惠券";
        }
            break;
            
        default:
            break;
    }
    [self showNoTextStateHud];
    MyDiscountResponse *response = [[MyDiscountResponse alloc] initWithType:type andWithCurrentPage:self.currentPage];
    response.delegate = self;
    [response start];
}

- (void)createUI
{
    [super createUI];
    self.tableView.frame = CGRectMake(0, 40, kScreenWidth, kScreenHeight - 40);
    _segment = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText:@"可用优惠券"},
                                                              @{VOSegmentText:@"历史优惠券"}]];
    _segment.frame = CGRectMake(0, 64, kScreenWidth, 40);
    _segment.contentStyle = VOContentStyleTextAlone;
    _segment.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    _segment.backgroundColor = BG_GRAY_COLOR;
    _segment.selectedBackgroundColor = _segment.backgroundColor;
    _segment.allowNoSelection = NO;
    _segment.indicatorThickness = 4;
    _segment.selectedTextColor = NAVIBAR_GREEN_COLOR;
    _segment.selectedIndicatorColor = NAVIBAR_GREEN_COLOR;
    [_segment addTarget:self action:@selector(swipSegmentWithIndexPath:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segment];
    [self.tableView.header beginRefreshing];
}

- (void)swipSegmentWithIndexPath:(NSIndexPath *)indexpath
{
    [self.dataArr removeAllObjects];
    [self.tableView.header beginRefreshing];
}

- (UIView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 104, kScreenWidth, kScreenHeight)];
        _emptyView.backgroundColor = GRAY_COLOR;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, kScreenHeight * 0.5 - 40, kScreenWidth, 80);
        [btn setTitle:@"暂无记录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(getDiscountOperation) forControlEvents:UIControlEventTouchUpInside];
        
        [_emptyView addSubview:btn];
    }
    
    return _emptyView;
}

#pragma mark MyDiscountResponseDelete
- (void)getDiscountListWithArray:(NSMutableArray *)disArr
{
    if (self.currentPage == 1) {
        [self.dataArr removeAllObjects];
        self.dataArr = disArr;
    }else{
        [self.dataArr addObjectsFromArray:disArr];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        if (self.currentPage == 1) {
            [self.tableView.header endRefreshing];
        }else{
            [self.tableView.footer endRefreshing];
        }
        [self.view insertSubview:self.tableView aboveSubview:self.emptyView];
        [self.view bringSubviewToFront:self.segment];
        [self.tableView reloadData];
    });
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self showStateHudWithText:text];
    if (self.currentPage == 1) {
        [self.tableView.header endRefreshing];
    }else{
        [self.tableView.footer endRefreshing];
        self.currentPage -= 1;
    }
    [self stopStateHud];
    [self.view addSubview:self.emptyView];
}

- (void)noDataArr
{
    if (self.currentPage == 1) {
        [self.tableView.header endRefreshing];
        [self.view addSubview:self.emptyView];
    }else{
        [self.tableView.footer endRefreshing];
        self.currentPage -= 1;
    }

    [self stopStateHud];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DISCOUNT_CELL = @"discount_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DISCOUNT_CELL];
    if (!cell) {
        cell = [[MyDiscountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DISCOUNT_CELL];
    }
    [(MyDiscountCell *)cell setDiscount:self.dataArr[indexPath.row]];
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

@end