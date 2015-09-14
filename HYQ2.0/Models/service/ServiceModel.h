//
//  ServiceModel.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/24.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"

@interface ServiceModel : BaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *DesStr;
@property (nonatomic, copy) NSString *logoPath;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSNumber *OldPrice;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *payCount;
@property (nonatomic, strong) NSNumber *colCount;

@end