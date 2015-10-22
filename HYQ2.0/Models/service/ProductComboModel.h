//
//  ProductComboModel.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"
/*
    产品搭配套餐
 */
@interface ProductComboModel : BaseModel

@property (nonatomic, strong) NSNumber *pdTypeId;
@property (nonatomic, strong) NSNumber *pdid;
@property (nonatomic, strong) NSNumber *pdprice;
@property (nonatomic, strong) NSString *pdname;

@end
