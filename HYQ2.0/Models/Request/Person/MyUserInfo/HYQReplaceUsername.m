//
//  HYQReplaceUsername.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/8.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQReplaceUsername.h"
#import "HYQUserManager.h"
@implementation HYQReplaceUsername

- (id)initWithNickName:(NSString *)username
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        NSDictionary *userInfo = [[HYQUserManager sharedUserManager] userInfo];
        
        [dic setValue:[userInfo objectForKey:@"uid"] forKey:@"uid"];
        [dic setValue:[userInfo objectForKey:@"username"] forKey:@"realName"];
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(replaceUsernameSucceed)]) {
            [self.delegate replaceUsernameSucceed];
        }
    }else if([[responseObject objectForKey:@"code"] integerValue] == 2){
        if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
            [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
        }
    }
}

- (NSString *)methodPath
{
    return REPLACE_NAME_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end