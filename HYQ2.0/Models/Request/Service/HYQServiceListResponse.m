//
//  HYQServiceListResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQServiceListResponse.h"
#import "ServiceModel.h"
@implementation HYQServiceListResponse

- (id)initWithType:(NSString *)type andWithCurrentPage:(NSUInteger)page
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        
        if (type) {
            [dic setObject:type forKey:@"typeName"];
        }
        
        if (page) {
            [dic setObject:[NSNumber numberWithInteger:page] forKey:@"pageSize"];
        }
        
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
        if ([responseObject objectForKey:@"products"]) {
            NSArray *arr = [responseObject objectForKey:@"products"];
            NSMutableArray *modelArr = [ServiceModel objectArrayWithKeyValuesArray:arr];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getServiceListWithArray:)]) {
                [self.delegate getServiceListWithArray:modelArr];
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
    return PRODUCT_LIST_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end