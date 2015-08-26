//
//  HYQActivityResponse.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/25.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"

@protocol  HYQActivityResponseDelegate<NSObject>

- (void)getActivityInfoWith:(NSMutableArray *)dataArr;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface HYQActivityResponse : HYQResponse

@property (nonatomic, assign) id<HYQActivityResponseDelegate> delegate;

- (id)initWithKind:(NSUInteger)kind andWithCurrentPage:(NSUInteger)currentPage;

@end