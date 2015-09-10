//
//  MyAddressResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyAddressResponse.h"
#import "HYQUserManager.h"
#import "AddressModel.h"

@implementation MyAddressResponse

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
        if ([responseObject objectForKey:@"address"]) {
            NSArray *arr = [responseObject objectForKey:@"address"];
            NSMutableArray *modelArr = [AddressModel objectArrayWithKeyValuesArray:arr];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getAddressArrayWith:)]) {
                [self.delegate getAddressArrayWith:modelArr];
            }
        }
    }else if([[responseObject objectForKey:@"code"] integerValue] == 2){
        if ([self.delegate respondsToSelector:@selector(noDataArr)]) {
            [self.delegate noDataArr];
        }
    }
}

- (NSString *)methodPath
{
    return MY_ADDRESS_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end