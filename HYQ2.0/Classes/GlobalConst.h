//
//  GlobalConst.h
//  HYQ
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UME_APPKEY              @"5d5405f67e58e6ed1001dbe"
//------------------界面常量--------------------

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define STATUS_BAR_HEIGHT           20.0f

//------------------色值--------------------

#define USERNAME_COLOR              [UIColor colorWithRed:21.0/255  green:21.0/255  blue:21.0/255   alpha:1]
#define TIME_COLOR                  [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255  alpha:1]
#define NAVIBAR_GREEN_COLOR         [UIColor colorWithRed:142.0/255  green:198.0/255  blue:63.0/255   alpha:1]
//--------------------------------------------
#define ORANGE_COLOR                [UIColor colorWithRed:1.000 green:0.478 blue:0.275  alpha:1]
#define BLUE_COLOR                  [UIColor colorWithRed:0.1   green:0.45  blue:0.79   alpha:1]
#define GRAY_COLOR                  [UIColor colorWithRed:0.925 green:0.925 blue:0.925  alpha:1]
//#define title
#define LINE_COLOR                  [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1]
#define BG_GRAY_COLOR               [UIColor colorWithRed:240.0/255 green:241.0/255 blue:242.0/255 alpha:1]

//------------------Web页面地址--------------------

//-----------------判断屏幕大小--------------------
#define IS_IPHONE5                  [[UIScreen mainScreen] bounds].size.height == 568.0f
#define IS_IHPONE4                  [[UIScreen mainScreen] bounds].size.height == 480.0f
//-----------------资讯活动base------------------------
#define ACTIVITY_BASE_URL           @"http://m.haoyuanqu.com/web/weixinpay2/news!details.action?id="
#define LOCAL_HOST                  @"http://192.168.1.93:90/"
#define IMAGE_HOST                  @"http://192.168.1.93:90/resources/iosimg/"