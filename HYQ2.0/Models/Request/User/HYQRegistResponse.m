//
//  HYQRegistResponse.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQRegistResponse.h"

@implementation HYQRegistResponse

- (id)initWithPhone:(NSString *)phone andWithCode:(NSString *)code andWithVerCode:(NSString *)vercode andWithSPhone:(NSString *)sphone
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        
        if (phone) {
            [dic setObject:phone forKey:@"phone"];
        }
        
        if (code) {
            [dic setObject:code forKey:@"psw"];
        }
        
        if (vercode) {
            [dic setObject:vercode forKey:@"yzm"];
        }
        
        if (sphone) {
            [dic setObject:sphone forKey:@"sphone"];
        }
        
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (NSString *)methodPath
{
    return REGIST_INTERFACE;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    
    if (responseObject) {
        if ([responseObject objectForKey:@"code"]) {
            NSNumber *code = [responseObject objectForKey:@"code"];
            
            if ([code integerValue] == 1) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(registSucceed)]) {
                    [self.delegate registSucceed];
                }
            }else{
                if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
                    [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
                }
            }
        }
    }else{
        
    }
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end
