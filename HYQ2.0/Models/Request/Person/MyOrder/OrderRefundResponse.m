//
//  OrderRefundResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/27.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "OrderRefundResponse.h"
#import "HYQUserManager.h"

@implementation OrderRefundResponse

- (id)initWithSubIDArr:(NSString *)IDArr
            andWithOid:(NSNumber *)oid
      andWithReasonArr:(NSString *)reasonArr
    andWithOtherReason:(NSString *)reason
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
        NSDictionary *userInfo = [[HYQUserManager sharedUserManager] userInfo];
        
        if (oid) {
            [dic setObject:oid forKey:@"oid"];
        }
        
        if (IDArr) {
            [dic setObject:IDArr forKey:@"subOrderIds"];
        }
        
        if (reasonArr) {
            [dic setObject:reasonArr forKey:@"synopsis"];
        }
        
        if (reason) {
            [dic setObject:reason forKey:@"introduce"];
        }
        
        [dic setObject:[userInfo objectForKey:@"uid"] forKey:@"userid"];
        [dic setObject:@"IOS" forKey:@"biaoshi"];
        
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(refundSucceed)]) {
            [self.delegate refundSucceed];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(refundFailedWithText:)]) {
            [self.delegate refundFailedWithText:[responseObject objectForKey:@"msg"]];
        }
    }
}

- (NSString *)methodPath
{
    return REFUND_SAVE_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力~"];
    }
}
@end
