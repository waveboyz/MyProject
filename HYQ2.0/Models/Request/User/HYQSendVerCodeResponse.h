//
//  HYQSendVerCodeResponse.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
@protocol HYQSendVerCodeResponseDelegate <NSObject>

- (void)sendVerCodeSucceed;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface HYQSendVerCodeResponse : HYQResponse

@property (nonatomic, assign) id<HYQSendVerCodeResponseDelegate> delegate;

- (id)initWithPhoneNumber:(NSString *)phone;

@end
