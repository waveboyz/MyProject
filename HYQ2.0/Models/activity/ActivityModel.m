//
//  ActivityModel.m
//  HYQ
//
//  Created by waveboyz on 15/6/26.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dictionary];
    }

    return self;
}

+(instancetype)activityWithDictionary:(NSDictionary *)dictionary
{
    return [[ActivityModel alloc] initWithDictionary:dictionary];
}

@end
