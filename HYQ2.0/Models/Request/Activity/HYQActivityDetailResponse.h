//
//  HYQActivityDetailResponse.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/25.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"

@protocol  HYQActivityDetailResponseDelegate<NSObject>

- (void)getActivityDetailInfoWith:(NSDictionary *)info;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface HYQActivityDetailResponse : HYQResponse

@property (nonatomic, assign) id<HYQActivityDetailResponseDelegate>delegate;

- (id)initWithAid:(NSUInteger)aid;

@end
