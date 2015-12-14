//
//  OrderRefundResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/27.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
     订单退款申请
 */
@protocol OrderRefundResponseDelegate <NSObject>

@optional
- (void)refundSucceed;
- (void)refundFailedWithText:(NSString *)text;
- (void)wrongOperationWithText:(NSString *)text;

@end
@interface OrderRefundResponse : HYQResponse

- (id)initWithSubIDArr:(NSString *)IDArr
            andWithOid:(NSNumber *)oid
      andWithReasonArr:(NSString *)reasonArr
    andWithOtherReason:(NSString *)reason;
@property (nonatomic, weak) id<OrderRefundResponseDelegate> delegate;

@end
