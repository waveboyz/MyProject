//
//  MyAddressDeleteResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    删除地址
 */
@protocol MyAddressDeleteResponse <NSObject>

- (void)deleteSucceed;
@optional
- (void)wrongOperationWithText:(NSString *)text;

@end

@interface MyAddressDeleteResponse : HYQResponse

@property (nonatomic, weak) id<MyAddressDeleteResponse> delegate;

- (id)initWithAid:(NSUInteger)aid;

@end