//
//  HYQLoginResponse.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"

@protocol HYQLoginResponseDelegate <NSObject>

- (void)getResponseDictionary:(NSDictionary *)dictionary;

@end

@interface HYQLoginResponse : HYQResponse

@property (nonatomic, assign) id<HYQLoginResponseDelegate> delegate;

- (id)initWithPhoneNumber:(NSString *)phone andWithPassWord:(NSString *)password;

@end