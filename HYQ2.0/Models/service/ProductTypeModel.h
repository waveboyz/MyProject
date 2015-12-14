//
//  ProductTypeModel.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"
#import "ProductComboModel.h"
/*
    产品服务类型
 */
@interface ProductTypeModel : BaseModel

@property (nonatomic, strong) NSNumber *pdTypeId;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, copy)   NSString *pname;
@property (nonatomic, copy)   NSString *psname;
@property (nonatomic, retain) NSArray  *productDetatil;
@end
