//
//  MyAddressAddController.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/1.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressModel.h"
/*
    添加地址
 */
@protocol MyAddressAddControllerDelegate <NSObject>

//返回新添加地址对象
@optional
//- (void)addAddressSucceedWithAddress:(AddressModel *)address;
- (void)addAddressSucceed;

@end

@interface MyAddressAddController : BaseViewController
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, assign) id<MyAddressAddControllerDelegate> delegate;

@end