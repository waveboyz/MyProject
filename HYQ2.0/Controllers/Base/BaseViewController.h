//
//  BaseViewController.h
//  HYQ
//
//  Created by 周翔 on 15/6/17.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"
#import "MBProgressHUD.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

@interface BaseViewController : UIViewController
<
MBProgressHUDDelegate
>

@property (nonatomic, retain) MBProgressHUD *stateHud;

//带文字提示框
- (void)showStateHudWithText:(NSString *)text;

//时间等待菊花
- (void)showNoTextStateHud;

//关闭等待菊花
- (void)stopStateHud;

//自定义构建UI
- (void)createUI;

@end
