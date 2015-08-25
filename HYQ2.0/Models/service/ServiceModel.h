//
//  ServiceModel.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/24.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"

@interface ServiceModel : BaseModel

@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *ImgUrl;
@property (nonatomic, copy) NSString *DesStr;
@property (nonatomic, strong) NSNumber *OldPrice;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *PurchaseCnt;
@property (nonatomic, strong) NSNumber *CollectCnt;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)serviceWithDictionary:(NSDictionary *)dictionary;

@end
