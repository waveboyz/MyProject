//
//  ProductTypeModel.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"
/*
    产品服务类型
 */
@interface ProductTypeModel : BaseModel

@property (nonatomic, strong) NSNumber *pdTypeId;
@property (nonatomic, strong) NSNumber *pdtprice;
@property (nonatomic, strong) NSNumber *pdtunit;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, copy)   NSString *pdtname;

@end
