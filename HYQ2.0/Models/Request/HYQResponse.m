//
//  HYQResponse.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/7.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
#import "AFNetworking.h"

#define TIMEOUT     30
@implementation HYQResponse

- (void)start
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    [manager POST:[self methodPath]
       parameters:_params
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              [self performSelectorOnMainThread:@selector(decodeJsonOperationWithObject:) withObject:responseObject waitUntilDone:YES];
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error){
              NSLog(@"请求失败");
              NSLog(@"%@",[error localizedDescription]);
              [self badNetWork];
          }];
}

- (NSMutableDictionary *)params
{
    if (nil == _params) {
        _params = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    
    return _params;
}

- (NSString *)methodPath
{
    return nil;
}

- (void)setUploadDictionary:(NSMutableDictionary *)dictionary
{
    self.params = dictionary;
    NSLog(@"%@",dictionary);
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{

}

- (void)badNetWork
{

}

@end