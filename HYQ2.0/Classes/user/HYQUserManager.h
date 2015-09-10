//
//  HYQUserManager.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYQUserManager : NSObject

+ (HYQUserManager *)sharedUserManager;

- (BOOL)isLogin;
- (BOOL)logout;

- (BOOL)isRememberPsw;
- (BOOL)savePsw:(NSString *)psw;
- (NSString *)getPsw;

- (NSDictionary *)userInfo;
- (BOOL)updateUserInfo:(NSDictionary *)userData;

@end