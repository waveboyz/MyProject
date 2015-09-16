//
//  ServicePayOrderResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/15.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServicePayOrderResponse.h"
#import "HYQUserManager.h"

@implementation ServicePayOrderResponse

- (id)initWithPid:(NSNumber *)pid andWithAid:(NSNumber *)aid andWithOnum:(NSNumber *)onum andWithTotalPrice:(NSNumber *)price andWithMsg:(NSString *)msg
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
        NSDictionary *userinfo = [[HYQUserManager sharedUserManager] userInfo];
        
        [dic setObject:[userinfo objectForKey:@"uid"] forKey:@"uid"];
        if (pid) {
            [dic setObject:pid forKey:@"pid"];
        }
        
        if (aid) {
            [dic setObject:aid forKey:@"aid"];
        }

        if (onum) {
            [dic setObject:onum forKey:@"onum"];
        }

        if (price) {
            [dic setObject:price forKey:@"pay"];
        }

        if (msg) {
            [dic setObject:msg forKey:@"buyMsg"];
        }

        [dic setObject:@"IOS端" forKey:@"biaoshi"];
        
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if (responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(getPayOrderSucceedWithPayOrder:andOid:)]) {
                NSNumber *tradeNO = [responseObject objectForKey:@"orderNum"];
                NSNumber *oid = [responseObject objectForKey:@"oid"];
                [self.delegate getPayOrderSucceedWithPayOrder:tradeNO andOid:oid];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
                [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
            }
            
        }
    }
}

- (NSString *)methodPath
{
    return GET_PAYORDER_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end