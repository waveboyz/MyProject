//
//  HYQResponse.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/7.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYQInterfaceMethod.h"

@interface HYQResponse : NSObject

@property (nonatomic, strong) NSMutableDictionary *params;

- (void)getresponseOperation;

//接口路径
- (NSString *)methodPath;

- (void)decodeJsonOperationWithObject:(id)responseObject;

- (void)setUploadDictionary:(NSMutableDictionary *)dictionary;

- (void)badNetWork;

@end