//
//  DistrictModel.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/7.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"

@interface DistrictModel : BaseModel

@property (nonatomic, copy) NSString *location;
@property (nonatomic, assign) NSNumber *locationID;

@end