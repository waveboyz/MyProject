//
//  MyExtendResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
 我的推广
 */
@protocol MyExtendResponseDelegate <NSObject>

- (void)getExtendArrayWith:(NSMutableArray *)exArr;

@optional

- (void)wrongOperationWithText:(NSString *)text;
- (void)noDataArr;

@end

@interface MyExtendResponse : HYQResponse

@property (nonatomic, assign) id<MyExtendResponseDelegate>delegate;

- (id)initWithCurrentPage:(NSUInteger)page;

@end
