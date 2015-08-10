//
//  HYQResponse.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/7.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
#import "AFNetworking.h"

@implementation HYQResponse

- (void)getresponseOperation
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://192.168.0.65:90/weixinServlet"
       parameters:@{@"A":@"1",@"B":@"2",@"C":@"3"}
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              NSLog(@"%@",responseObject);
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error){
              NSLog(@"请求失败");
              NSLog(@"%@",[error localizedDescription]);
          }];
}

@end