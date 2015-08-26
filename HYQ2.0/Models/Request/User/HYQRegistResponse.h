//
//  HYQRegistResponse.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"

@protocol HYQRegistResponseDelegate <NSObject>

- (void)sendVerCodeSucceed;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface HYQRegistResponse : HYQResponse

@end
