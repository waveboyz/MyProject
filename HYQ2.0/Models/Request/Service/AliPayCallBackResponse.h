//
//  AliPayCallBackResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/15.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    支付宝回调接口
 */
@protocol AliPayCallBackResponseDelegate <NSObject>

- (void)getPayResult;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface AliPayCallBackResponse : HYQResponse

@property (nonatomic, weak) id<AliPayCallBackResponseDelegate> delegate;

- (id)initWithTradeNO:(NSNumber *)tradeNO andWithTradeStatus:(NSNumber *)tradeStatus andWithResult:(NSString *)result;

@end