//
//  RefundScheduleResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/29.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    退款进度查询
 */
@class OrderModel;
@class RefundScheduleModel;
@protocol RefundScheduleResponseDelegate <NSObject>

@optional
- (void)getScheduleWith:(OrderModel *)order andWithSubArr:(NSArray *)subArr andWithScheDuel:(RefundScheduleModel *)schedule;
- (void)wrongOperationWithText:(NSString *)text;
@end

@interface RefundScheduleResponse : HYQResponse

- (id)initWithOid:(NSNumber *)oid;
@property (nonatomic, weak) id<RefundScheduleResponseDelegate> delegate;
@end
