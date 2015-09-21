//
//  MyAddressResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
 地址列表
 */
@protocol MyAddressResponseDelegate <NSObject>

- (void)getAddressArrayWith:(NSMutableArray *)array;

@optional

- (void)wrongOperationWithText:(NSString *)text;
- (void)noDataArr;

@end

@interface MyAddressResponse : HYQResponse

@property (nonatomic, weak) id<MyAddressResponseDelegate> delegate;

@end