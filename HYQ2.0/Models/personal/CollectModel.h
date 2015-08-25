//
//  CollectModel.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/24.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"
/*
 我的收藏
 */

@interface CollectModel : BaseModel

@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *ImgUrl;
@property (nonatomic, strong) NSNumber *Sid;
@property (nonatomic, strong) NSNumber *Price;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)collectWithDictionary:(NSDictionary *)dictionary;

@end
