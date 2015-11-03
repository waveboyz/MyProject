//
//  MyOrderDetailResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/26.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
 订单详情
 */
@class SubOrderModel;
@class OrderInfoModel;
@protocol MyOrderDetailResponseDelegate <NSObject>

@optional
- (void)getInfoSucceedWith:(OrderInfoModel *)info andWith:(NSArray *)subArr;
- (void)wrongOperationWithText:(NSString *)text;

@end

@interface MyOrderDetailResponse : HYQResponse

- (id)initWithOid:(NSNumber *)oid;
@property (nonatomic, weak) id<MyOrderDetailResponseDelegate> delegate;

@end
