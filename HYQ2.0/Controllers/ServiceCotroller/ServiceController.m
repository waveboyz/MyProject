//
//  FirstViewController.m
//  TestProject
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanTec. All rights reserved.
//

#import "ServiceController.h"
#import "VOSegmentedControl.h"
#import "ServiceViewCell.h"
#import "ServiceDetailController.h"
#import "ServiceModel.h"
#import "HYQServiceListResponse.h"
#import "HYQServiceTitleResponse.h"
#import "HYQServiceListResponse.h"
#import "ServiceTitleModel.h"

@interface ServiceController ()
<
    HYQServiceTitleResponseDelegate,
    HYQServiceListResponseDelegate
>

@property (nonatomic, strong) VOSegmentedControl *segment;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIView *badNetView;

@end

@implementation ServiceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"产品服务";
    [self getTitleOperation];
}

- (void)loadNewData
{
    [super loadNewData];
    [self getProductDetailOperation];
}

- (void)loadMoreData
{
    [super loadMoreData];
    [self.tableView.footer beginRefreshing];
    [self getProductDetailOperation];
}
//获取信息分类
- (void)getTitleOperation
{
    [self showNoTextStateHud];
    HYQServiceTitleResponse *response = [[HYQServiceTitleResponse alloc] init];
    response.delegate = self;
    [response start];
}

//获取信息
- (void)getProductDetailOperation
{
    [self showNoTextStateHud];
    ServiceTitleModel *model = self.titleArr[_segment.selectedSegmentIndex];
    HYQServiceListResponse *response = [[HYQServiceListResponse alloc] initWithType:model.name andWithCurrentPage:self.currentPage];
    response.delegate = self;
    [response start];
}

//获取信息分类视图加载
- (void)createUI
{
    [super createUI];
    _segment = [[VOSegmentedControl alloc] init];
    NSMutableArray *segArr = [NSMutableArray new];
    
    //取出信息分类给segment构建
    for (ServiceTitleModel *model in self.titleArr) {
        NSDictionary *dic = @{VOSegmentText:model.name};
        [segArr addObject:dic];
    }
    
    _segment.segments = segArr;
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
    
    [self.tableView.header beginRefreshing];
}

- (void)swipSegmentWithIndexPath:(NSUInteger)indexpath
{
    [self.tableView.header beginRefreshing];
}

//-----------网络错误视图懒加载---------------
- (UIView *)badNetView
{
    if (!_badNetView) {
        _badNetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _badNetView.backgroundColor = GRAY_COLOR;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, kScreenHeight * 0.5 - 40, kScreenWidth, 80);
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if ([self.titleArr count]) {
            [btn addTarget:self action:@selector(getProductDetailOperation) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [btn addTarget:self action:@selector(getTitleOperation) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [_badNetView addSubview:btn];
    }
    
    return _badNetView;
}

//----------------无数据源视图懒加载------------------------
- (UIView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _emptyView.backgroundColor = GRAY_COLOR;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, kScreenHeight * 0.5 - 40, kScreenWidth, 80);
        [btn setTitle:@"暂无记录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(getProductDetailOperation) forControlEvents:UIControlEventTouchUpInside];
        
        [_emptyView addSubview:btn];
    }
    
    return _emptyView;
}

#pragma mark HYQServiceTitleResponseDelegate
- (void)getTitleWith:(NSArray *)titleArr
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        self.titleArr = titleArr;
        [self createUI];
    });
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self showStateHudWithText:text];
    [self.tableView.header endRefreshing];
    if (self.tableView) {
        [self.view insertSubview:self.badNetView belowSubview:_segment];
    }else{
        [self.view bringSubviewToFront:self.badNetView];
    }
}

#pragma mark HYQServiceListResponseDelegate
- (void)getServiceListWithArray:(NSMutableArray *)infoArr
{
    if (self.currentPage == 1) {
        [self.dataArr removeAllObjects];
        self.dataArr = infoArr;
    }else {
        [self.dataArr addObjectsFromArray:infoArr];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        if (self.currentPage == 1) {
            [self.tableView.header endRefreshing];
        }else{
            [self.tableView.footer endRefreshing];
        }

        [self.tableView reloadData];
        [self.view insertSubview:self.tableView belowSubview:_segment];
    });
}

- (void)noDataArr
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        if (self.currentPage == 1) {
            [self.tableView.header endRefreshing];
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
    static NSString *SERVICE_CELL = @"service_cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:SERVICE_CELL];
    
    if (!cell) {
        cell = [[ServiceViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SERVICE_CELL];
    }
    [(ServiceViewCell *)cell setService:self.dataArr[indexPath.row]];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceDetailController *detail = [[ServiceDetailController alloc] initWithServiceModel:self.dataArr[indexPath.row]];
    detail.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UINavigationController * jackNavigationController = [[UINavigationController alloc] initWithRootViewController:detail];
    [self presentViewController:jackNavigationController animated:YES completion:^(void){}];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.5f;
}

@end