//
//  HYQActivityResponse.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/25.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQInforTitleResponse.h"
#import "ActivityTitleModel.h"

@implementation HYQInforTitleResponse

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
        if ( [[responseObject objectForKey:@"code"] integerValue] == 1) {
            if ([responseObject objectForKey:@"newType"]) {
                NSArray *arr =  [responseObject objectForKey:@"newType"];
                NSArray *titleArr = [ActivityTitleModel objectArrayWithKeyValuesArray:arr];
                if (self.delegate && [self.delegate respondsToSelector:@selector(getInfoWith:)]) {
                    [self.delegate getInfoWith:titleArr];
                }
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
                [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
            }
        }
    }else{

    }
}

- (NSString *)methodPath
{
    return INFORMATION_TITLE_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end