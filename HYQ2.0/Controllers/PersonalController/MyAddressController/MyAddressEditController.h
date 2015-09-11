//
//  MyAddressEditController.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressModel.h"
/*
    修改地址
 */
@protocol MyAddressEditControllerDelegate <NSObject>

//返回修改地址对象
- (void)correctAddressSucceedWith:(AddressModel *)address;

@optional
- (void)deleteAddressSucceed;

@end

@interface MyAddressEditController : BaseViewController
<
UITableViewDataSource,
UITableViewDelegate
>

- (id)initWithAddressModel:(AddressModel *)address;
@property (nonatomic, assign) id<MyAddressEditControllerDelegate> delegate;

@end
