//
//  PaymentModel.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/24.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"
/*
我的提成
 */

typedef NS_ENUM(NSInteger, PaymentState)
{
    PaymentInState,
    PaymentOutState
};

@interface PaymentModel : BaseModel

@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Time;
@property (nonatomic, strong) NSNumber *Price;
@property (nonatomic, assign) PaymentState payState;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)paymentWithDictionary:(NSDictionary *)dictionary;

@end
