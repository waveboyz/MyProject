//
//  MyAddressPickController.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/2.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseViewController.h"
#import "DistrictModel.h"
/*
    选取地址
 */
@protocol MyAddressPickControllerDelegate <NSObject>

- (void)finishPickAddressWith:(DistrictModel *)model;

@end

@interface MyAddressPickController : BaseViewController
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, assign) id<MyAddressPickControllerDelegate> delegate;

@end