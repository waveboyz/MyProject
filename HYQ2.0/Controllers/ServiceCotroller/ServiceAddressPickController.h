//
//  ServiceAddressPickController.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/9.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseViewController.h"

@class AddressModel;
@protocol ServiceAddressPickControllerDelegate <NSObject>

- (void)finishPickWithAddress:(AddressModel *)address;

@end

@interface ServiceAddressPickController : BaseViewController

- (id)initWithAddressArray:(NSArray *)addressArr;
@property (nonatomic, assign) id<ServiceAddressPickControllerDelegate> delegate;

@end
