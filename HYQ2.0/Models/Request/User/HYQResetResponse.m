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
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        if (phone) {
            [dic setObject:phone forKey:@"phone"];
        }
        
        if (password) {
            [dic setObject:password forKey:@"newPwd"];
        }
        
        if (vercode) {
            [dic setObject:vercode forKey:@"yzm"];
        }
        
        [self setUploadDictionary:dic];
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
    if (responseObject) {
        if ([responseObject objectForKey:@"code"]) {
            NSNumber *code = [responseObject objectForKey:@"code"];
            if ([code integerValue] == 1) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(resetPswSucceed)]) {
                    [self.delegate resetPswSucceed];
                }
            }else{
                if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
                    [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
                }
            }
            
        }
    }
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end
