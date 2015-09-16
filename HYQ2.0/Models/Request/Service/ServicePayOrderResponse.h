//
//  ServicePayOrderResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/15.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    获取订单号和订单ID
 */
@protocol ServicePayOrderResponseDelegate <NSObject>

- (void)getPayOrderSucceedWithPayOrder:(NSNumber *)payorder andOid:(NSNumber *)oid;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface ServicePayOrderResponse : HYQResponse

@property (nonatomic, assign) id<ServicePayOrderResponseDelegate>delegate;

- (id)initWithPid:(NSNumber *)pid
       andWithAid:(NSNumber *)aid
      andWithOnum:(NSNumber *)onum
andWithTotalPrice:(NSNumber *)price
       andWithMsg:(NSString *)msg;

@end