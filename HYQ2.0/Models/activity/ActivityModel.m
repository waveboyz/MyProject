//
//  ActivityModel.m
//  HYQ
//
//  Created by waveboyz on 15/6/26.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
//        self.TITLE = [dic objectForKey:@"title"];
//        self.END_TIME = [dic objectForKey:@"end_time"];
//        self.BEGIN_TIME = [dic objectForKey:@"begin_time"];
//        self.LOCATION = [dic objectForKey:@"location"];
//        self.IS_END = [dic objectForKey:@"is_end"];
        
        [self setValuesForKeysWithDictionary:dic];
    }

    return self;
}

+ (instancetype)activityWithDictionary:(NSDictionary *)dic
{
    return [[ActivityModel alloc] initWithDictionary:dic];
}

@end
