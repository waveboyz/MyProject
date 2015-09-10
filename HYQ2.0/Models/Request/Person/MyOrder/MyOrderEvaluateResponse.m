//
//  MyOrderEvaluateResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/2.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyOrderEvaluateResponse.h"

@implementation MyOrderEvaluateResponse

- (id)initWithOid:(NSUInteger)oid
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
        if ([responseObject objectForKey:@"orders"]) {

        }
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
