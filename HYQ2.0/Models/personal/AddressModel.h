//
//  AddressModel.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/24.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel

@property (nonatomic, copy) NSString *linkman;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *provinceCode;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *district; //区
@property (nonatomic, copy) NSString *districtCode;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, assign) NSNumber *linkPhone;
@property (nonatomic, assign) NSNumber *tacitiy;
@property (nonatomic, assign) NSNumber *aid;

@end