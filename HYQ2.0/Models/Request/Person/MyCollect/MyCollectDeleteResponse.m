//
//  MyCollectDeleteResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyCollectDeleteResponse.h"
#import "HYQUserManager.h"

@implementation MyCollectDeleteResponse

- (id)initWithDeleteArr:(NSArray *)array
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        NSMutableString *mutableStr = [NSMutableString new];
        
        for (NSNumber *fid in array) {
            [mutableStr appendFormat:@"%@,",[fid stringValue]];
        }
        [dic setObject:mutableStr forKey:@"fid"];
        
        NSNumber *uid = [[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"uid"];
        [dic setObject:uid forKey:@"uid"];
        
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteSucceed)]) {
            [self.delegate deleteSucceed];
        }
    }else if([[responseObject objectForKey:@"code"] integerValue] == 2){
        if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
            [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
        }
    }
}

- (NSString *)methodPath
{
    return MY_COLLECT_DELETE_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}
@end
