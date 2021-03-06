//
//  HYQLoginResponse.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQLoginResponse.h"
#import "GlobalConst.h"

@interface HYQLoginResponse ()

@property (nonatomic, copy) NSString *psw;
@property (nonatomic, copy) NSString *phone;
@end

@implementation HYQLoginResponse

- (id)initWithPhoneNumber:(NSString *)phone andWithPassWord:(NSString *)password
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        
        if (phone) {
            _phone = phone;
            [dic setObject:phone forKey:@"phone"];
        }
        
        if (password) {
            _psw = password;
            [dic setObject:password forKey:@"psw"];
        }
        
        [self setUploadDictionary:dic];
    }

    return self;
}

- (NSString *)methodPath
{
    return LOGIN_INTERFACE;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    
    if (responseObject) {
        if ([responseObject objectForKey:@"code"]) {
            NSNumber *code = [responseObject objectForKey:@"code"];

            if ([code integerValue] == 1) {
                NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithCapacity:3];
                [userDic setObject:[responseObject objectForKey:@"userId"] forKey:@"uid"];
                [userDic setObject:[responseObject objectForKey:@"realName"] forKey:@"realName"];
                [userDic setObject:[responseObject objectForKey:@"account"] forKey:@"property"];
                NSString *str = [responseObject objectForKey:@"imagery"];
                [userDic setObject:str forKey:@"avatarUrl"];
                [userDic setObject:_psw forKey:@"psw"];
                [userDic setObject:_phone forKey:@"phone"];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(getResponseDictionary:)]) {
                    [self.delegate getResponseDictionary:userDic];
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