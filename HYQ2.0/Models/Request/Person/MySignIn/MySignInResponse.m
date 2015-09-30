//
//  MySignInResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/30.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MySignInResponse.h"

@implementation MySignInResponse

- (id)init
{
    if (self = [super init]) {
        NSNumber *uid = [[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"uid"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:1];
        
        [dic setObject:uid forKey:@"uid"];
        
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {

    }else if([[responseObject objectForKey:@"code"] integerValue] == 2){
        if ([self.delegate respondsToSelector:@selector(noDataArr)]) {
            [self.delegate noDataArr];
        }
    }
}

- (NSString *)methodPath
{
    return MY_SIGN_IN_INTERFACE;
}

- (void)badNetWork
{
    if (![self.delegate isEqual:[NSNull null]] && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end
