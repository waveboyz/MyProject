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

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *lastTime;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, strong) NSNumber *money;
@property (nonatomic, strong) NSNumber *cid;

@end