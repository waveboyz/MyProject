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

typedef NS_ENUM(NSInteger, TableviewState){
    TableviewStateNone,
    TableviewStateNetDrop,
    TableviewStateLoading,
    TableviewStateDone
};

@interface BaseRefreshController : UIViewController
<
    MBProgressHUDDelegate,
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, retain)MBProgressHUD *stateHud;
@property (nonatomic, assign) NSUInteger    maxSegCnt;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic)       TableviewState state;
@property (nonatomic, strong) UIView    *loadingView;
@property (nonatomic, strong) UIView    *emptyView;
@property (nonatomic, strong) UIView    *netDropView;

//下拉刷新
- (void)loadNewData;

//上拉刷新
- (void)loadMoreData;

//带文字提示信息
- (void)showStateHudWithText:(NSString *)text;

//时间等待菊花
- (void)showNoTextStateHud;

@end
