//
//  ServicePurchaseController.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseViewController.h"
#import "ServiceModel.h"
#import "OrderModel.h"
/*
    产品购买页
 */
@interface ServicePurchaseController : BaseViewController
<
    UITableViewDataSource,
    UITableViewDelegate
>

- (id)initWithService:(ServiceModel *)service;
- (id)initWithOrder:(OrderModel *)order;

@property (nonatomic, assign) ServiceModel *service;
@property (nonatomic, assign) OrderModel   *order;

@end