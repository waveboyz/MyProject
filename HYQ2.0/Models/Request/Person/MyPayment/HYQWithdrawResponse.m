//
//  WithdrawRecordResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQWithdrawResponse.h"
#import "PaymentModel.h"
#import "HYQUserManager.h"

@implementation HYQWithdrawResponse
- (id)initWithType:(NSString *)type andWithCurrentPage:(NSUInteger)page
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:3];
        
        if (type) {
            [dic setObject:type forKey:@"status"];
        }
        
        if (page) {
            [dic setObject:[NSNumber numberWithInteger:page] forKey:@"pageSize"];
        }
        NSNumber *uid = [[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"uid"];
        [dic setObject:uid forKey:@"uid"];
        
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if (responseObject) {
        if ( [[responseObject objectForKey:@"code"] integerValue] == 1) {
            if ([responseObject objectForKey:@"deducts"]) {
                NSArray *arr =  [responseObject objectForKey:@"deducts"];
                NSMutableArray *titleArr = [PaymentModel objectArrayWithKeyValuesArray:arr];
                if (self.delegate && [self.delegate respondsToSelector:@selector(getInfoWith:)]) {
                    [self.delegate getInfoWith:titleArr];
                }
            }
        }else if([[responseObject objectForKey:@"code"] integerValue] == 2){
            if (self.delegate && [self.delegate respondsToSelector:@selector(noDataArr)]) {
                [self.delegate noDataArr];
            }
        }
    }else{
        
    }
}

- (NSString *)methodPath
{
    return MY_TRADE_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}
@end