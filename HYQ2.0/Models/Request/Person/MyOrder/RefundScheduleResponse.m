//
//  RefundScheduleResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/29.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "RefundScheduleResponse.h"
#import "OrderModel.h"
#import "SubOrderModel.h"
#import "RefundScheduleModel.h"

@implementation RefundScheduleResponse

- (id)initWithOid:(NSNumber *)oid
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        if (oid) {
            [dic setObject:oid forKey:@"oid"];
        }
        
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
        OrderModel *order = [OrderModel objectWithKeyValues:[responseObject objectForKey:@"order"]];
        NSArray *subArr = [SubOrderModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"subOrder"]];
        RefundScheduleModel *refund = [RefundScheduleModel objectWithKeyValues:[responseObject objectForKey:@"tuiKuan"]];
        if (self.delegate && [self.delegate respondsToSelector:@selector(getScheduleWith:andWithSubArr:andWithScheDuel:)]) {
            [self.delegate getScheduleWith:order andWithSubArr:subArr andWithScheDuel:refund];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
            [self.delegate wrongOperationWithText:@"未获取数据~"];
        }
    }
}

- (NSString *)methodPath
{
    return REFUND_PROGRESS_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力~"];
    }
}
@end
