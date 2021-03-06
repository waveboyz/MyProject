//
//  ServiceTitleModel.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"
/*
    产品列表页标题模型
 */
@interface ServiceTitleModel : BaseModel

@property (nonatomic, assign) NSUInteger tid;
@property (nonatomic, copy) NSString *name;

@end