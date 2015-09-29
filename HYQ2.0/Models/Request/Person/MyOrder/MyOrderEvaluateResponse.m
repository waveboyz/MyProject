//
//  MyOrderEvaluateResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/2.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyOrderEvaluateResponse.h"
#import "HYQUserManager.h"

@implementation MyOrderEvaluateResponse

- (id)initWithOid:(NSNumber *)oid
     andWithPayID:(NSNumber *)payID
    andWithValue1:(NSUInteger)value1
    andWithValue2:(NSUInteger)value2
    andWithValue3:(NSUInteger)value3
    andWithValue4:(NSUInteger)value4
   andWithComment:(NSString *)comment
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
        NSDictionary *userInfo  = [[HYQUserManager sharedUserManager] userInfo];
        [dic setObject:[userInfo objectForKey:@"uid"] forKey:@"uid"];
        if (oid) {
            [dic setObject:oid forKey:@"oid"];
        }

        if (payID) {
            [dic setObject:payID forKey:@"settlementId"];
        }

        if (value1) {
            [dic setObject:[NSNumber numberWithInteger:value1] forKey:@"serviceLevel"];
        }

        if (value2) {
            [dic setObject:[NSNumber numberWithInteger:value2] forKey:@"serviceLevel1"];
        }

        
        if (value3) {
            [dic setObject:[NSNumber numberWithInteger:value3] forKey:@"serviceLevel2"];
        }
        
        if (value4) {
            [dic setObject:[NSNumber numberWithInteger:value4] forKey:@"serviceLevel3"];
        }
        
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(evaluateSucceed)]) {
            [self.delegate evaluateSucceed];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
            [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
        }
    }
}

- (NSString *)methodPath
{
    return ORDER_EVALUATE_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end
