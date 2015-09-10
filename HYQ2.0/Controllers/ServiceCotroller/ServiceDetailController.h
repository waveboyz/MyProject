//
//  ServiceDetailController.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseViewController.h"
#import "ServiceModel.h"
/*
    产品详情页
 */
@interface ServiceDetailController : BaseViewController
<
    UIAlertViewDelegate
>

- (id)initWithServiceModel:(ServiceModel *)service;

@end