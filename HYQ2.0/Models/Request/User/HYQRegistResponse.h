//
//  HYQRegistResponse.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"

@protocol HYQRegistResponseDelegate <NSObject>

- (void)registSucceed;

@optional
- (void)wrongOperationWithText:(NSString *)text;

@end

@interface HYQRegistResponse : HYQResponse

@property (nonatomic, weak) id<HYQRegistResponseDelegate> delegate;

- (id)initWithPhone:(NSString *)phone andWithCode:(NSString *)code andWithVerCode:(NSString *)vercode andWithSPhone:(NSString *)sphone;

@end
