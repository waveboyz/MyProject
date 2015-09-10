//
//  HYQServiceListResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
 产品列表页
 */
@protocol HYQServiceListResponseDelegate <NSObject>

- (void)getServiceListWithArray:(NSMutableArray *)infoArr;

@optional

- (void)wrongOperationWithText:(NSString *)text;
- (void)noDataArr;

@end

@interface HYQServiceListResponse : HYQResponse

@property (nonatomic, assign) id<HYQServiceListResponseDelegate> delegate;

- (id)initWithType:(NSString *)type andWithCurrentPage:(NSUInteger)page;

@end