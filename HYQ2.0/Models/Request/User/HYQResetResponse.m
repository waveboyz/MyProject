//
//  HYQResetResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/8/26.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResetResponse.h"

@implementation HYQResetResponse

- (id)initWithPhone:(NSString *)phone andWithPsw:(NSString *)password andWithVerCode:(NSString *)vercode
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (NSString *)methodPath
{
    return RESET_INTERFACE;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);    
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end
