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
    [manager POST:[self methodPath]
       parameters:_params
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              [self performSelectorOnMainThread:@selector(decodeJsonOperationWithObject:) withObject:responseObject waitUntilDone:YES];
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error){
              NSLog(@"请求失败");
              NSLog(@"%@",[error localizedDescription]);
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

}

- (void)decodeJsonOperationWithObject:(id)responseObject
{

}

@end