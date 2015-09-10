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

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, strong) NSNumber *fid;
@property (nonatomic, strong) NSNumber *price;

@end
