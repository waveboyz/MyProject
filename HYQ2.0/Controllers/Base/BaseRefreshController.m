//
//  BaseRefreshController.m
//  HYQ
//
//  Created by 周翔 on 15/6/17.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "BaseRefreshController.h"

@interface BaseRefreshController ()

@end

@implementation BaseRefreshController

- (id)init
{
    if (self = [super init]) {
//        _refershState = RefreshNew;
        _currentPage = 1;
        _totalPage = 0;
        _dataArr = [NSMutableArray new];
        _titleArr = [NSArray new];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, kScreenWidth, kScreenHeight - 152) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    
    MJRefreshNormalHeader *headerView = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [headerView setTitle:@"下拉刷新~" forState:MJRefreshStateIdle];
    [headerView setTitle:@"松开刷新~" forState:MJRefreshStatePulling];
    [headerView setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    _tableView.header = headerView;
    
    MJRefreshBackNormalFooter *footerView = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footerView setTitle:@"上拉获取更多~" forState:MJRefreshStateIdle];
    [footerView setTitle:@"松开刷新~" forState:MJRefreshStatePulling];
    [footerView setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    _tableView.footer = footerView;
    
    [self.view addSubview:_tableView];
}

//下拉刷新获取最新数据
- (void)loadNewData
{
    _currentPage = 1;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        _currentPage = 1;
//        // 拿到当前的下拉刷新控件，结束刷新状态
//        [self.tableView.header endRefreshing];
//        [self showStateHudWithText:@"下拉刷新成功"];
//    });
}

//上拉刷新获取更多数据
- (void)loadMoreData
{
    _currentPage += 1;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        
//        // 拿到当前的下拉刷新控件，结束刷新状态
//        [self.tableView.footer endRefreshing];
//        [self showStateHudWithText:@"上拉刷新成功！"];
//    });
}

- (void)showStateHudWithText:(NSString *)text
{
    if (!self.stateHud) {
        _stateHud = [[MBProgressHUD alloc] initWithView:self.view];
        _stateHud.delegate = self;
        [self.view addSubview:_stateHud];
    }
    self.stateHud.mode = MBProgressHUDModeText;
    self.stateHud.opacity = 0.6;
    self.stateHud.labelText = text;
    self.stateHud.labelFont = [UIFont systemFontOfSize:12.0f];
    [self.stateHud show:YES];
    [self.stateHud hide:YES afterDelay:1.2];
    self.stateHud = nil;
}

- (void)showNoTextStateHud
{
    if (!self.stateHud) {
        self.stateHud = [[MBProgressHUD alloc] initWithView:self.view];
        self.stateHud.delegate = self;
        [self.view addSubview:self.stateHud];
    }
    self.stateHud.mode = MBProgressHUDModeIndeterminate;
    self.stateHud.opacity = 0.6;
    [self.stateHud show:YES];
}

- (void)stopStateHud
{
    [self.stateHud hide:YES afterDelay:0.5];
    self.stateHud = nil;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *NORMAL_CELL = @"normal_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NORMAL_CELL];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NORMAL_CELL];
        UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 0.5)];
        lineLbl.backgroundColor = LINE_COLOR;
        [cell.contentView addSubview:lineLbl];
        
        cell.imageView.image = [UIImage imageNamed:@"avatar_placeholder"];
        cell.imageView.clipsToBounds = YES;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.5f;
}

@end