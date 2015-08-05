//
//  ActivityModel.h
//  HYQ
//
//  Created by waveboyz on 15/6/26.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)activityWithDictionary:(NSDictionary *)dic;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *begin_time;
@property (nonatomic, retain) NSString *end_time;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, assign) BOOL      is_end;

@end
