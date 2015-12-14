//
//  SubOrderModel.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/26.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"
/*
    子订单模型
 */
@interface SubOrderModel : BaseModel

@property (nonatomic, copy) NSString *button;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) NSNumber *month;
@property (nonatomic, assign) NSNumber *sid;
@property (nonatomic, assign) NSNumber *subOrderNum;

@end