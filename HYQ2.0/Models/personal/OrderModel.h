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

@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *ImgUrl;
@property (nonatomic, strong) NSNumber *Oid;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, assign) OrderState orderState;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)orderWithDictionary:(NSDictionary *)dictionary;

@end
