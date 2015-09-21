//
//  HYQResetVerResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/15.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
 找回密码验证码
 */
@protocol HYQResetVerResponseDelegate <NSObject>

- (void)sendVerCodeSucceed;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface HYQResetVerResponse : HYQResponse

@property (nonatomic, weak) id<HYQResetVerResponseDelegate> delegate;

- (id)initWithPhone:(NSString *)phone;

@end
