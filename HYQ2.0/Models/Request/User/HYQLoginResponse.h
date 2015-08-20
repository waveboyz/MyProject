//
//  HYQLoginResponse.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"

@interface HYQLoginResponse : HYQResponse

- (id)initWithPhoneNumber:(NSString *)phone andWithPassWord:(NSString *)password;

@end