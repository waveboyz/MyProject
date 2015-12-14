//
//  MyBankWithDrawResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/16.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyBankWithDrawResponse.h"

@implementation MyBankWithDrawResponse

- (id)initWithCard:(NSString *)card andWithName:(NSString *)name andWithCash:(NSString *)cash
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
        NSNumber *uid = [[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"uid"];
        [dic setObject:uid forKey:@"uid"];
        
        if (card) {
            [dic setObject:card forKey:@"cardNum"];
        }
        
        if (name) {
            [dic setObject:name forKey:@"name"];
        }
        
        if (cash) {
            [dic setObject:cash forKey:@"money"];
        }

        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {

    }else if([[responseObject objectForKey:@"code"] integerValue] == 0){
        if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
            [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
        }
    }
}

- (NSString *)methodPath
{
    return ADDRESS_MODIFI_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end
