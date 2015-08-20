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
    [self.params setObject:dictionary forKey:@"body"];
}

- (NSString *)methodPath
{
    return nil;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    if (responseObject && [responseObject isKindOfClass:[NSString class]]) {
        NSData *respData = [responseObject dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSDictionary *respDict = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableLeaves error:nil];

        
    }
}

@end