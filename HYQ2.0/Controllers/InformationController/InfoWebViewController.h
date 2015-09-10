//
//  BaseWebVIewController.h
//  HYQ
//
//  Created by 周翔 on 15/6/16.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "GlobalConst.h"
/*
    咨询活动详情
 */
@interface InfoWebViewController : BaseViewController
<
UIWebViewDelegate
>

//通过url和设定标题初始化控制器
- (id)initWithUrl:(NSString *)url andTitle:(NSString *)title;

@end
