//
//  RefundScheduleController.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/28.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseViewController.h"
/*
    退款进度查询
 */
@class OrderModel;
@class OrderInfoModel;
@interface RefundScheduleController : BaseViewController

- (id)initWithOrder:(OrderModel *)order;

@end
