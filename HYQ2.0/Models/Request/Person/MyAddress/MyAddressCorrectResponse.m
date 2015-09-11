//
//  MyAddressCorrectResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyAddressCorrectResponse.h"
#import "HYQUserManager.h"

@implementation MyAddressCorrectResponse

- (id)initWithEnterprise:(NSString *)enterprise
             andWithName:(NSString *)name
            andWithPhone:(NSString *)phone
          andWithAddress:(NSString *)address
         andWithProvince:(NSString *)province
                 andCity:(NSString *)city
                andState:(NSString *)state
               andTacity:(NSUInteger)tacity
              andWithAid:(NSString *)aid
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:10];
        NSNumber *uid = [[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"uid"];
        [dic setObject:uid forKey:@"uid"];
        
        if (enterprise) {
            [dic setObject:enterprise forKey:@"enterprise"];
        }
        
        if (name) {
            [dic setObject:name forKey:@"linkman"];
        }
        
        if (phone) {
            [dic setObject:phone forKey:@"linkPhone"];
        }
        
        if (address) {
            [dic setObject:address forKey:@"address"];
        }
        
        if (province) {
            [dic setObject:province forKey:@"sheng"];
        }
        
        if (city) {
            [dic setObject:city forKey:@"city"];
        }
        
        if (state) {
            [dic setObject:state forKey:@"qu"];
        }
        
        if (tacity) {
            [dic setObject:[NSNumber numberWithInteger:tacity] forKey:@"tacitiy"];
        }
        
        if (aid) {
            [dic setObject:[NSNumber numberWithInteger:[aid integerValue]] forKey:@"aid"];
        }
        
        [self setUploadDictionary:dic];
    }

    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(correctSucceedWith:)]) {
            [self.delegate correctSucceedWith:[responseObject objectForKey:@"aid"]];
        }
    }else if([[responseObject objectForKey:@"code"] integerValue] == 0){
        if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
            [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
        }
    }
}

- (NSString *)methodPath
{
    return ADDRESS_MODIFI_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end