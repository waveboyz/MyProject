//
//  HYQResetResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/26.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"

@protocol HYQResetResponseDelegate <NSObject>

- (void)resetPswSucceed;

@optional

- (void)wrongOperationWithText:(NSString *)text;
@end

@interface HYQResetResponse : HYQResponse

@property (nonatomic, weak) id<HYQResetResponseDelegate> delegate;

- (id)initWithPhone:(NSString *)phone andWithPsw:(NSString *)password andWithVerCode:(NSString *)vercode;

@end
