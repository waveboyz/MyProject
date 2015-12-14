//
//  HYQAdvertiseResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/19.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQAdvertiseResponse.h"

@implementation HYQAdvertiseResponse

- (id)init
{
    if (self = [super init]) {

    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if (responseObject) {
        if ([responseObject objectForKey:@"code"]) {
            NSString *strPath = [responseObject objectForKey:@"rpath"];
            if (self.delegate && [self.delegate respondsToSelector:@selector(getAdvertiseSucceedWithUrl:)]) {
                [self.delegate getAdvertiseSucceedWithUrl:strPath];
            }
            }else{
                if (self.delegate && [self.delegate respondsToSelector:@selector(getAdvertiseFalse)]) {
                    [self.delegate getAdvertiseFalse];
                }
            }
        }
}

- (NSString *)methodPath
{
    return LAUNCH_ADVERTISE_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(getAdvertiseFalse)]) {
        [self.delegate getAdvertiseFalse];
    }
}

@end