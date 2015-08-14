//
//  BaseRefreshController.m
//  HYQ
//
//  Created by 周翔 on 15/6/17.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "BaseRefreshController.h"

static const CGFloat MJDuration = 1.0;

@interface BaseRefreshController ()

@end

@implementation BaseRefreshController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    __weak __typeof(self) weakSelf = self;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight - 40) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    
    MJRefreshNormalHeader *headerView = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [headerView setTitle:@"我将带头冲锋~" forState:MJRefreshStateIdle];
    [headerView setTitle:@"放下无尽让我们好好说话" forState:MJRefreshStatePulling];
    [headerView setTitle:@"新姿势解锁中..." forState:MJRefreshStateRefreshing];
    _tableView.header = headerView;
    
    [_tableView.header beginRefreshing];
    
    MJRefreshBackNormalFooter *footerView = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footerView setTitle:@"想要解锁更多吗？" forState:MJRefreshStateIdle];
    [footerView setTitle:@"少侠还不松手？" forState:MJRefreshStatePulling];
    [footerView setTitle:@"感觉真是日了狗" forState:MJRefreshStateRefreshing];
    _tableView.footer = footerView;
    
    [self.view addSubview:_tableView];
}

//下拉刷新获取最新数据
- (void)loadNewData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.header endRefreshing];
        [self showStateHudWithText:@"下拉刷新成功"];
    });
}

//上拉刷新获取更多数据
- (void)loadMoreData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.footer endRefreshing];
        [self showStateHudWithText:@"上拉刷新成功！"];
    });
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
    [self.stateHud hide:YES afterDelay:0.8];
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end