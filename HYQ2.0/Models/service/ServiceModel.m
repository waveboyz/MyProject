//
//  ServiceModel.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/24.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceModel.h"

@implementation ServiceModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
    }
    
    return self;
}

+ (instancetype)serviceWithDictionary:(NSDictionary *)dictionary
{

    return [[self alloc] initWithDictionary:dictionary];
}

@end