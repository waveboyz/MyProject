//
//  BaseRefreshController.h
//  HYQ
//
//  Created by 周翔 on 15/6/17.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
/*
    刷新页
 */
static const CGFloat MJDuration = 1.0;
@interface BaseRefreshController : UIViewController
<
    MBProgressHUDDelegate,
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, retain)MBProgressHUD *stateHud;
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UIView    *loadingView;
@property (nonatomic, strong) UIView    *netDropView;
// 当前页
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) NSUInteger totalPage;
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, retain) NSArray    *titleArr;

//下拉刷新
- (void)loadNewData;

//上拉刷新
- (void)loadMoreData;

//带文字提示信息
- (void)showStateHudWithText:(NSString *)text;

//时间等待菊花
- (void)showNoTextStateHud;

//关闭等待菊花
- (void)stopStateHud;

- (void)createUI;
@end