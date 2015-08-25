//
//  ActivityModel.h
//  HYQ
//
//  Created by waveboyz on 15/6/26.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface ActivityModel : BaseModel

@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Up_time;
@property (nonatomic, copy) NSString *WebUrl;
@property (nonatomic, copy) NSString *ImgUrl;
@property (nonatomic, strong) NSNumber *CmtCount;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+(instancetype)activityWithDictionary:(NSDictionary *)dictionary;

@end