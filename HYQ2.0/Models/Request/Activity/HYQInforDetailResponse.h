//
//  HYQActivityDetailResponse.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/25.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"

@protocol  HYQInforDetailResponseDelegate<NSObject>

- (void)getActivityDetailInfoWithArray:(NSMutableArray *)infoArr;

@optional

- (void)wrongOperationWithText:(NSString *)text;
- (void)noDataArr;

@end

@interface HYQInforDetailResponse : HYQResponse

@property (nonatomic, assign) id<HYQInforDetailResponseDelegate>delegate;

- (id)initWithType:(NSString *)type andWithCurrentPage:(NSUInteger)page;

@end
