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

@interface BaseRefreshController : UITableViewController
<
MBProgressHUDDelegate
>

@property (nonatomic, retain)MBProgressHUD *stateHud;
@property (nonatomic, strong) NSMutableArray *dataArr;

//下拉刷新
- (void)loadNewData;

//上拉刷新
- (void)loadMoreData;

//带文字提示信息
- (void)showStateHudWithText:(NSString *)text;

//时间等待菊花
- (void)showNoTextStateHud;

@end
