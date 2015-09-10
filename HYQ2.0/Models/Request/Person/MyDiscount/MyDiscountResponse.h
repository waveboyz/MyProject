//
//  MyDiscountResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    优惠券
 */
@protocol MyDiscountResponseDelete <NSObject>

- (void)getDiscountListWithArray:(NSMutableArray *)disArr;

@optional

- (void)wrongOperationWithText:(NSString *)text;
- (void)noDataArr;

@end

@interface MyDiscountResponse : HYQResponse


@property (nonatomic, assign) id<MyDiscountResponseDelete> delegate;

- (id)initWithType:(NSString *)type andWithCurrentPage:(NSUInteger)page;

@end