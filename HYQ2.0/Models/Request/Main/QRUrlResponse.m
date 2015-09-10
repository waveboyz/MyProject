//
//  QRUrlResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/9.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "QRUrlResponse.h"
#import "HYQUserManager.h"

@implementation QRUrlResponse

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);

}

- (NSString *)methodPath
{
    NSDictionary *userInfo  =  [[HYQUserManager sharedUserManager] userInfo];
    NSNumber *phone = [userInfo objectForKey:@"phone"];
    return [NSString stringWithFormat:@"%@%@",GET_QRURL_INTERFACE,[phone stringValue]];
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end
