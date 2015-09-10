//
//  MyOrderResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    我的订单
 */
@protocol MyOrderResponseDelegate <NSObject>

- (void)getOrderListWithArray:(NSMutableArray *)orderArr;

@optional

- (void)wrongOperationWithText:(NSString *)text;
- (void)noDataArr;

@end

@interface MyOrderResponse : HYQResponse

@property (nonatomic, assign) id<MyOrderResponseDelegate>delegate;

- (id)initWithTypeNanme:(NSString *)type andWithCurrentPage:(NSUInteger)page;

@end