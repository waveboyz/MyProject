//
//  ServiceIsCollectResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/7.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceIsCollectResponse.h"
#import "HYQUserManager.h"

@implementation ServiceIsCollectResponse

- (id) initWithPid:(NSNumber *)pid
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        [dic setObject:pid forKey:@"pid"];
        NSDictionary *userInfo = [[HYQUserManager sharedUserManager] userInfo];
        [dic setObject:[userInfo objectForKey:@"uid"] forKey:@"uid"];
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if (responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(getCollectSucceedWithIsCollected:)]) {
                NSNumber *isCollected = [responseObject objectForKey:@"iSFavorite"];
                [self.delegate getCollectSucceedWithIsCollected:[isCollected boolValue]];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
                [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
            }
            
        }
    }
}

- (NSString *)methodPath
{
    return SERVICE_INFO_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end
