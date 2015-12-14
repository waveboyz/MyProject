//
//  HYQServiceTitleResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQServiceTitleResponse.h"
#import "ServiceTitleModel.h"

@implementation HYQServiceTitleResponse

- (id)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if (responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
            NSArray *arr = [ServiceTitleModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"proType"]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getTitleWith:)]) {
                [self.delegate getTitleWith:arr];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
                [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
            }
        
        }
    }
}

- (NSString *)methodPath
{
    return PRODUCT_TITLE_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end