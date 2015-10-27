//
//  OrderInfoModel.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/26.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"
/*
    订单详情页订单信息
 */
@interface OrderInfoModel : BaseModel

@property (nonatomic, strong) NSNumber *integeral;
@property (nonatomic, strong) NSNumber *money;
@property (nonatomic, strong) NSNumber *oid;
@property (nonatomic, strong) NSNumber *onum;
@property (nonatomic, strong) NSNumber *oprice;
@property (nonatomic, copy)   NSString *olinkMan;
@property (nonatomic, copy)   NSString *oname;
@property (nonatomic, copy)   NSString *otypeName;
@property (nonatomic, copy)   NSString *pname;

@end
