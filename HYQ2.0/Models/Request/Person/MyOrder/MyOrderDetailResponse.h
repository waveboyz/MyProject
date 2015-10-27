//
//  MyOrderDetailResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/26.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"

@class SubOrderModel;
@class OrderInfoModel;
@protocol MyOrderDetailResponseDelegate <NSObject>

@optional
- (void)getInfoSucceedWith:(OrderInfoModel *)info andWith:(NSArray *)subArr;
- (void)wrongOperationWithText:(NSString *)text;

@end

@interface MyOrderDetailResponse : HYQResponse

- (id)initWithOid:(NSInteger)oid;
@property (nonatomic, weak) id<MyOrderDetailResponseDelegate> delegate;

@end
