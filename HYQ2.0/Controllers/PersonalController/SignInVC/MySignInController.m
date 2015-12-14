//
//  MySignInController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/30.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MySignInController.h"
#import "MySignInCell.h"
#import "MySignInResponse.h"

@interface MySignInController ()
<
    MySignInResponseDelegate
>

@property (nonatomic, strong) UIView        *headerView;
@property (nonatomic, strong) UIView        *sectionHeader;
@property (nonatomic, strong) UILabel       *numLbl;
@property (nonatomic, strong) UIView        *emptyView;
@property (nonatomic, strong) UIView        *badNetView;

@end

@implementation MySignInController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    self.title = @"我的积分";
}

- (void)createUI
{
    [super createUI];
    [self.view addSubview:self.headerView];
    self.tableView.frame = CGRectMake(0, 160, kScreenWidth, kScreenHeight - 160);
    self.tableView.tableHeaderView = self.sectionHeader;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView.header beginRefreshing];
}

- (void)loadNewData
{
    [super loadNewData];
    [self getSignInListOperation];
}

- (void)loadMoreData
{
    [super loadMoreData];
    [self getSignInListOperation];
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 160)];
        _headerView.backgroundColor = NAVIBAR_GREEN_COLOR;
        
        UILabel *desLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 50, 30, 100, 20)];
        desLbl.font = [UIFont systemFontOfSize:13.0f];
        desLbl.textColor = [UIColor whiteColor];
        desLbl.textAlignment = NSTextAlignmentCenter;
        desLbl.text = @"我的积分";
        [_headerView addSubview:desLbl];
        
        _numLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 60, 80, 120, 30)];
        _numLbl.font = [UIFont systemFontOfSize:41.0f];
        _numLbl.textColor = [UIColor whiteColor];
        _numLbl.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:_numLbl];
        
        UILabel *desLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 70, 130, 140, 15)];
        desLbl1.font = [UIFont systemFontOfSize:8.0f];
        desLbl1.textColor = [UIColor greenColor];
        desLbl1.textAlignment = NSTextAlignmentCenter;
        desLbl1.text = @"明日继续签到可再领取5积分哦！";
        [_headerView addSubview:desLbl1];
    }

    return _headerView;
}

- (UIView *)sectionHeader
{
    if (!_sectionHeader) {
        _sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        _sectionHeader.backgroundColor = [UIColor whiteColor];
        
        UILabel *deslbl1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 30)];
        deslbl1.font = [UIFont systemFontOfSize:13.0f];
        deslbl1.textColor = [UIColor grayColor];
        deslbl1.text = @"来源/用途";
        [_sectionHeader addSubview:deslbl1];
        
        UILabel *deslbl2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 90, 0, 70, 30)];
        deslbl2.font = [UIFont systemFontOfSize:13.0f];
        deslbl2.textColor = [UIColor grayColor];
        deslbl2.text = @"积分变化";
        deslbl2.textAlignment = NSTextAlignmentRight;
        [_sectionHeader addSubview:deslbl2];
        
        UILabel *linelbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, kScreenWidth - 40, 0.5)];
        linelbl.textColor = [UIColor grayColor];
        [_sectionHeader addSubview:linelbl];
    }
    
    return _sectionHeader;
}

- (void)getSignInListOperation
{
    [self showNoTextStateHud];
    MySignInResponse *response = [[MySignInResponse alloc] init];
    response.delegate  = self;
    [response start];
}

- (UIView *)badNetView
{
    if (!_badNetView) {
        _badNetView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, kScreenWidth, kScreenHeight - 160)];
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
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, kScreenWidth, kScreenHeight - 160)];
        _emptyView.backgroundColor = GRAY_COLOR;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, kScreenHeight * 0.5 - 40, kScreenWidth, 80);
        [btn setTitle:@"暂无记录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(getSignInListOperation) forControlEvents:UIControlEventTouchUpInside];
        
        [_emptyView addSubview:btn];
    }
    
    return _emptyView;
}

#pragma mark MySignInResponseDelegate
- (void)getSignArrSucceedWith:(NSMutableArray *)arr andWithNum:(NSNumber *)num
{
    if (self.currentPage == 1) {
        self.dataArr = arr;
    }else {
        [self.dataArr addObjectsFromArray:arr];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        if (self.currentPage == 1) {
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
            [self.view insertSubview:self.tableView aboveSubview:self.emptyView];
            [self.view bringSubviewToFront:self.headerView];
            _numLbl.text = [num stringValue];
        }else{
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];
            [self.view insertSubview:self.tableView aboveSubview:self.emptyView];
            [self.view bringSubviewToFront:self.headerView];
            _numLbl.text = [num stringValue];
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
    static NSString *SIGN_IN_CELL = @"sign_in_cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:SIGN_IN_CELL];
    if (!cell) {
        cell = [[MySignInCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SIGN_IN_CELL];
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
    
    return 70.5f;
}
@end
