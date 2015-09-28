//
//  HYQSendVerCodeResponse.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQSendVerCodeResponse.h"

@implementation HYQSendVerCodeResponse

- (id)initWithPhoneNumber:(NSString *)phone
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        
        if (phone) {
            [dic setObject:phone forKey:@"phone"];
        }

        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (NSString *)methodPath
{
    return SEND_VER_INTERFACE;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    
    if (responseObject) {
        if ([responseObject objectForKey:@"code"]) {
            NSNumber *code = [responseObject objectForKey:@"code"];
            
            if ([code integerValue] == 1) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(sendVerCodeSucceed)]) {
                    [self.delegate sendVerCodeSucceed];
                }
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
                    [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
                }
            }else if([code integerValue] == 3){
                if (self.delegate && [self.delegate respondsToSelector:@selector(phoneAlreadyExist)]) {
                    [self.delegate phoneAlreadyExist];
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
