//
//  OrderModel.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/24.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"
/*
 我的订单
 */

typedef NS_ENUM(NSInteger, OrderState){
    OrderDoneState,
    OrderPayState,
    OrderEvaluateState
};

@interface OrderModel : BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *statusBtn;
@property (nonatomic, copy) NSString *statusMsg;
@property (nonatomic, copy) NSNumber *orderNum;
@property (nonatomic, copy) NSString *proSummery;
@property (nonatomic, strong) NSNumber *settlementId;
@property (nonatomic, strong) NSNumber *oid;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSNumber *money;
@property (nonatomic, strong) NSNumber *num;

@end
