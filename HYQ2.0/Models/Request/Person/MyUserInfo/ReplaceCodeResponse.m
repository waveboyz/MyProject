//
//  ReplaceCodeResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/8.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ReplaceCodeResponse.h"
#import "HYQUserManager.h"

@implementation ReplaceCodeResponse

- (id)initWithCode:(NSString *)code
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        NSDictionary *userInfo  =  [[HYQUserManager sharedUserManager] userInfo];
        [dic setObject:code forKey:@"pwd"];
        [dic setObject:[userInfo objectForKey:@"uid"] forKey:@"uid"];
        
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(replaceCodeSucceed)]) {
            [self.delegate replaceCodeSucceed];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
            [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
        }
    }
}

- (NSString *)methodPath
{
    return REPLACE_PSW_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}


@end