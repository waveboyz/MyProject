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

- (id)initWithOid:(NSUInteger)oid
     andWithPayID:(NSString *)payID
    andWithValue1:(NSUInteger)value1
    andWithValue2:(NSUInteger)value2
    andWithValue3:(NSUInteger)value3
    andWithValue4:(NSUInteger)value4
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
        NSDictionary *userInfo  = [[HYQUserManager sharedUserManager] userInfo];
        [dic setObject:[userInfo objectForKey:@"uid"] forKey:@"uid"];
        [dic setObject:[NSNumber numberWithInteger:oid] forKey:@"oid"];
        [dic setObject:payID forKey:@"settlementId"];
        [dic setObject:[NSNumber numberWithInteger:value1] forKey:@"serviceLevel"];
        [dic setObject:[NSNumber numberWithInteger:value2] forKey:@"serviceLevel1"];
        [dic setObject:[NSNumber numberWithInteger:value3] forKey:@"serviceLevel2"];
        [dic setObject:[NSNumber numberWithInteger:value4] forKey:@"serviceLevel3"];
        
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {

    }else if([[responseObject objectForKey:@"code"] integerValue] == 2){

    }
}

- (NSString *)methodPath
{
    return MY_DISCOUNT_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end
