//
//  CollectOperationResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "CollectOperationResponse.h"
#import "HYQUserManager.h"
@implementation CollectOperationResponse

- (id)initWithPid:(NSNumber *)pid
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        NSDictionary *userInfo = [[HYQUserManager sharedUserManager] userInfo];
        NSNumber *uid = [userInfo objectForKey:@"uid"];
        [dic setObject:uid forKey:@"uid"];
        [dic setObject:pid forKey:@"pid"];
        
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectSucceed)]) {
            [self.delegate collectSucceed];
        }
    }else if([[responseObject objectForKey:@"code"] integerValue] == 3){
        if (self.delegate && [self.delegate respondsToSelector:@selector(deCollectSucceed)]) {
            [self.delegate deCollectSucceed];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
            [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
        }
    }
}

- (NSString *)methodPath
{
    return COLLECT_OPERATION_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end