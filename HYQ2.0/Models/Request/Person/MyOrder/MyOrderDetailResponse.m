//
//  MyOrderDetailResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/26.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyOrderDetailResponse.h"
#import "HYQUserManager.h"
#import "OrderInfoModel.h"
#import "SubOrderModel.h"

@implementation MyOrderDetailResponse

- (id)initWithOid:(NSNumber *)oid
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:3];
        
        if (oid) {
            [dic setObject:oid forKey:@"oid"];
//            [dic setObject:[NSNumber numberWithInteger:1931] forKey:@"oid"];
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
            OrderInfoModel *info = [OrderInfoModel objectWithKeyValues:[responseObject objectForKey:@"order"]];
            
            NSArray *subArr = [SubOrderModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"subOrder"]];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(getInfoSucceedWith:andWith:)]) {
                [self.delegate getInfoSucceedWith:info andWith:subArr];
            }
    }else if([[responseObject objectForKey:@"code"] integerValue] == 2){
        if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
            [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
        }
    }
}

- (NSString *)methodPath
{
    return ORDER_DETAIL_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力~"];
    }
}
@end
