//
//  MyOrderResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyOrderResponse.h"
#import "OrderModel.h"

@implementation MyOrderResponse

- (id)initWithTypeNanme:(NSString *)type andWithCurrentPage:(NSUInteger)page
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:3];
        
        if (type) {
            [dic setObject:type forKey:@"status"];
        }
        
        if (page) {
            [dic setObject:[NSNumber numberWithInteger:page] forKey:@"pageSize"];
        }
        
        NSNumber *uid = [[[HYQUserManager sharedUserManager] userInfo]objectForKey:@"uid"];
        
        [dic setObject:uid forKey:@"uid"];
        
        [self setUploadDictionary:dic];
    }

    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
        if ([responseObject objectForKey:@"orders"]) {
            NSArray *arr = [responseObject objectForKey:@"orders"];
            NSMutableArray *modelArr = [OrderModel objectArrayWithKeyValuesArray:arr];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getOrderListWithArray:)]) {
                [self.delegate getOrderListWithArray:modelArr];
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
    return MY_ORDER_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end