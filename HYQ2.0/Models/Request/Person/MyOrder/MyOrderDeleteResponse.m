//
//  MyOrderDeleteResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyOrderDeleteResponse.h"

@implementation MyOrderDeleteResponse

- (id)initWithOid:(NSUInteger)oid andWithPayID:(NSNumber *)payID
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
        NSDictionary *userInfo  = [[HYQUserManager sharedUserManager] userInfo];
        [dic setObject:[userInfo objectForKey:@"uid"] forKey:@"uid"];
        [dic setObject:[NSNumber numberWithInteger:oid] forKey:@"oid"];
        [dic setObject:payID forKey:@"settlementId"];

        [self setUploadDictionary:dic];
    }

    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteSucceed)]) {
            [self.delegate deleteSucceed];
            }
    }else{
        if ([self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
            [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
        }
    }
}

- (NSString *)methodPath
{
    return ORDER_DELETE_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end
