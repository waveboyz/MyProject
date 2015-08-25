//
//  HYQLoginResponse.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQLoginResponse.h"

@implementation HYQLoginResponse

- (id)initWithPhoneNumber:(NSString *)phone andWithPassWord:(NSString *)password
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        
        if (phone) {
            [dic setObject:phone forKey:@"phone"];
        }
        
        if (password) {
            [dic setObject:password forKey:@"psw"];
        }
        
        [self setUploadDictionary:dic];
    }

    return self;
}

- (void)setUploadDictionary:(NSMutableDictionary *)dictionary
{
    self.params = dictionary;
    NSLog(@"%@",self.params);
}

- (NSString *)methodPath
{
    return LOGIN_INTERFACE;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
//    
//        NSData *respData = [responseObject dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//        NSDictionary *respDict = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableLeaves error:nil];

//        if (self.delegate && [self.delegate respondsToSelector:@selector(getResponseDictionary:)]) {
//            [self.delegate getResponseDictionary:respDict];
//        }
    
    if (responseObject) {
        if ([responseObject objectForKey:@"userInfo"]) {
            NSDictionary *userInfo = [responseObject objectForKey:@"userInfo"];
            
            if (userInfo && [[userInfo objectForKey:@"account" ] isKindOfClass:[NSNumber class]]) {
                NSNumber *property = [userInfo objectForKey:@"account"];
                
                NSLog(@"%@",property);
                
            }
        }
    }
}

@end