//
//  QRUrlResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/9.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "QRUrlResponse.h"
#import "HYQUserManager.h"
#import "AFNetworking.h"

#define TIMEOUT     30

@implementation QRUrlResponse

- (void)start
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    [manager GET:[self methodPath] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        [self performSelectorOnMainThread:@selector(decodeJsonOperationWithObject:) withObject:responseObject waitUntilDone:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"请求失败");
        NSLog(@"%@",[error localizedDescription]);
        [self badNetWork];

    }];
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);

    NSString *imgstr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    if (imgstr != nil) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(getQRUrlSucceedWithUrl:)]) {
            [self.delegate getQRUrlSucceedWithUrl:imgstr];
        }
    }
    NSLog(@"%@",imgstr);

}

- (NSString *)methodPath
{
    NSDictionary *userInfo  =  [[HYQUserManager sharedUserManager] userInfo];
    NSNumber *phone = [userInfo objectForKey:@"phone"];
    NSString *returnStr =[NSString stringWithFormat:@"%@%@",GET_QRURL_INTERFACE,phone];
    return returnStr;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end
