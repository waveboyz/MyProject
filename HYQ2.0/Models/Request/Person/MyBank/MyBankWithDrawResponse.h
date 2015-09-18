//
//  MyBankWithDrawResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/16.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    提现道银行卡
 */
@protocol MyBankWithDrawResponseDelegate <NSObject>

- (void)withdrawSucceed;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface MyBankWithDrawResponse : HYQResponse

@property (nonatomic, assign) id<MyBankWithDrawResponseDelegate>delegate;

- (id)initWithCard:(NSString *)card andWithName:(NSString *)name andWithCash:(NSString *)cash;

@end