//
//  AddressModel.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/24.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel

@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *Phone;
@property (nonatomic, copy) NSString *Address;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)addressWithDictionary:(NSDictionary *)dictionary;

@end
