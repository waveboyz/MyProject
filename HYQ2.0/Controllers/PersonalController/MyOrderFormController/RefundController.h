//
//  RefundController.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/27.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseViewController.h"
/*
    订单退款页
 */
@class OrderModel;
@interface RefundController : BaseViewController

- (id)initWithSubArr:(NSArray *)arr andWithOrder:(OrderModel *)order;

@end
