//
//  MyOrderEvaluateResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/2.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    订单评价
 */
@protocol MyOrderEvaluateResponseDelegate <NSObject>

- (void)evaluateSucceed;
@optional
- (void)wrongOperationWithText:(NSString *)text;

@end

@interface MyOrderEvaluateResponse : HYQResponse

@property (nonatomic, assign) id<MyOrderEvaluateResponseDelegate> delegate;

- (id)initWithOid:(NSUInteger)oid;

@end