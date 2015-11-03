//
//  RefundScheduleModel.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/29.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"
/*
    退款进度模型
 */
@interface RefundScheduleModel : BaseModel

@property (nonatomic, copy) NSString *tkStatus;     //退款状态
@property (nonatomic, copy) NSString *tkCreateTime;     //退款创建时间
@property (nonatomic, copy) NSString *tksureTime;       //评审时间
@property (nonatomic, copy) NSString *tkShTime;         //退款审核通过时间
@property (nonatomic, copy) NSString *tkSeccessTime;    //退款完成时间

@end