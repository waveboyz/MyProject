//
//  InformationController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "InformationController.h"
#import "VOSegmentedControl.h"
#import "ActivityCell.h"
#import "InfoWebViewController.h"
#import "ActivityModel.h"
#import "HYQInforTitleResponse.h"
#import "HYQInforDetailResponse.h"
#import "ActivityTitleModel.h"

@interface InformationController ()
<
    HYQInforTitleResponseDelegate,
    HYQInforDetailResponseDelegate
>

@property (nonatomic, strong) VOSegmentedControl *segment;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIView *badNetView;

@end

@implementation InformationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"资讯活动";
    [self getTitleOperation];
}

- (void)loadNewData
{
    [super loadNewData];
    [self getInfoDetailOperation];
}

- (void)loadMoreData
{
    [super loadMoreData];
    [self.tableView.footer beginRefreshing];
    [self getInfoDetailOperation];
}

//获取信息分类
- (void)getTitleOperation
{
    [self showNoTextStateHud];
    HYQInforTitleResponse *response = [[HYQInforTitleResponse alloc] init];
    response.delegate = self;
    [response start];
}

//获取信息
- (void)getInfoDetailOperation
{
    [self showNoTextStateHud];
    ActivityTitleModel *model = self.titleArr[_segment.selectedSegmentIndex];
    HYQInforDetailResponse *response = [[HYQInforDetailResponse alloc] initWithType:model.title andWithCurrentPage:self.currentPage];
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
    for (ActivityTitleModel *model in self.titleArr) {
        NSDictionary *dic = @{VOSegmentText:model.title};
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
            [btn addTarget:self action:@selector(getInfoDetailOperation) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [btn addTarget:self action:@selector(getTitleOperation) forControlEvents:UIControlEventTouchUpInside];
        }

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
        [btn addTarget:self action:@selector(getInfoDetailOperation) forControlEvents:UIControlEventTouchUpInside];
        
        [_emptyView addSubview:btn];
    }
    
    return _emptyView;
}

- (void)swipSegmentWithIndexPath:(NSUInteger)indexpath
{
    [self.tableView.header beginRefreshing];
}

#pragma mark HYQInforTitleResponseDelegate
- (void)getInfoWith:(NSArray *)dataArr
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        self.titleArr = dataArr;
        [self createUI];
    });
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self showStateHudWithText:text];
    [self.tableView.header endRefreshing];
    if (_segment) {
        [self.view insertSubview:self.badNetView belowSubview:_segment];
    }else{
        [self.view insertSubview:self.badNetView aboveSubview:self.tableView];
    }
}

#pragma mark HYQInforDetailResponseDelegate
- (void)getActivityDetailInfoWithArray:(NSMutableArray *)infoArr
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
    static NSString *INFOR_CELL = @"info_cell";
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:INFOR_CELL];
    if (!cell) {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:INFOR_CELL];
    }
    [(ActivityCell *)cell setActivity:self.dataArr[indexPath.row]];

    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.5f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActivityModel *model = self.dataArr[indexPath.row];
    NSString *str = [[NSString alloc] initWithFormat:@"%@%ld",ACTIVITY_BASE_URL,[model.aid integerValue]];
    InfoWebViewController *webVC = [[InfoWebViewController alloc] initWithUrl:str andTitle:nil];
    
    [self presentViewController:webVC animated:YES completion:^(void){}];
}

@end