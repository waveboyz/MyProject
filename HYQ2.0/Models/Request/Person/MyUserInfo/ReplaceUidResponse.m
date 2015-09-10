//
//  ReplaceUidResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/6.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ReplaceUidResponse.h"

@implementation ReplaceUidResponse

- (id)init
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:10];
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
        if ([responseObject objectForKey:@"products"]) {
            
        }
    }else if([[responseObject objectForKey:@"code"] integerValue] == 2){
        
    }
}

- (NSString *)methodPath
{
    return REPLACE_UID_INTERFACE;
}

- (void)badNetWork
{

}

@end