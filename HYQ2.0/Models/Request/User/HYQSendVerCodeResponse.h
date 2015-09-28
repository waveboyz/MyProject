//
//  HYQSendVerCodeResponse.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    注册验证码
 */
@protocol HYQSendVerCodeResponseDelegate <NSObject>

- (void)sendVerCodeSucceed;

@optional

- (void)phoneAlreadyExist;
- (void)wrongOperationWithText:(NSString *)text;

@end

@interface HYQSendVerCodeResponse : HYQResponse

@property (nonatomic, weak) id<HYQSendVerCodeResponseDelegate> delegate;

- (id)initWithPhoneNumber:(NSString *)phone;

@end
