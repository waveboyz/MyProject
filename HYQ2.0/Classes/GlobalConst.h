//
//  GlobalConst.h
//  HYQ
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import <Foundation/Foundation.h>

//------------------界面常量--------------------

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define STATUS_BAR_HEIGHT           20.0f

//------------------色值--------------------

#define USERNAME_COLOR              [UIColor colorWithRed:21.0/255  green:21.0/255  blue:21.0/255   alpha:1]
#define TIME_COLOR                  [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255  alpha:1]
#define NAVIBAR_GREEN_COLOR         [UIColor colorWithRed:125.0/255  green:189.0/255  blue:49.0/255   alpha:1]
//--------------------------------------------
#define ORANGE_COLOR                [UIColor colorWithRed:1.000 green:0.478 blue:0.275  alpha:1]
#define BLUE_COLOR                  [UIColor colorWithRed:0.1   green:0.45  blue:0.79   alpha:1]
#define GRAY_COLOR                  [UIColor colorWithRed:0.925 green:0.925 blue:0.925  alpha:1]
//#define title
#define LINE_COLOR                  [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1]
#define BG_GRAY_COLOR               [UIColor colorWithRed:240.0/255 green:241.0/255 blue:242.0/255 alpha:1]

//------------------Web页面地址--------------------

// * 使用协议 *
extern NSString *const SERVICE_AGREEMENTS_URL;

//-----------------判断屏幕大小--------------------
#define IS_IPHONE5                  [[UIScreen mainScreen] bounds].size.height == 568.0f
#define IS_IHPONE4                  [[UIScreen mainScreen] bounds].size.height == 480.0f
