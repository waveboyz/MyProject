//
//  EvaluateModel.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/20.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"
/*
    评价模型
 */
@interface EvaluateModel : BaseModel

@property (nonatomic, strong) NSNumber *level0;
@property (nonatomic, strong) NSNumber *level1;
@property (nonatomic, strong) NSNumber *level2;
@property (nonatomic, strong) NSNumber *level3;

@end