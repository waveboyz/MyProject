//
//  MyOrderDetailController.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/23.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseRefreshController.h"

@class OrderModel;
@interface MyOrderDetailController : BaseRefreshController

- (id)initWithOrder:(OrderModel *)order;

@end
