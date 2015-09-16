//
//  AliPayCallBackResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/15.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "AliPayCallBackResponse.h"

@implementation AliPayCallBackResponse

- (id)initWithTradeNO:(NSNumber *)tradeNO andWithTradeStatus:(NSNumber *)tradeStatus andWithResult:(NSString *)result
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
        [dic setObject:tradeNO forKey:@"out_trade_no"];
        [dic setObject:tradeStatus forKey:@"trade_status"];
        [dic setObject:result forKey:@"result"];
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if (responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
            
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
                [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
            }
        }
    }
}

- (NSString *)methodPath
{
    return ALIPAY_CALLBACK_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end