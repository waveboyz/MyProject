//
//  BannerModel.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/27.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"

@interface BannerModel : BaseModel

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) NSNumber *bid;

@end
