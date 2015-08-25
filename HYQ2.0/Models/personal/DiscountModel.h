//
//  DiscountModel.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/24.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"
/*
 我的优惠券
 */

@interface DiscountModel : BaseModel

@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *DesStr;
@property (nonatomic, copy) NSString *BeginTime;
@property (nonatomic, copy) NSString *EndTime;
@property (nonatomic, strong) NSNumber *Price;
@property (nonatomic, strong) NSNumber *Did;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)discountWithDictionary:(NSDictionary *)dictionary;

@end