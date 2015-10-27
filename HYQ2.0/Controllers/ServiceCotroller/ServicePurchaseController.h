//
//  ServicePurchaseController.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseViewController.h"

@class ProductModel;
@class ProductTypeModel;
@class DistrictModel;
/*
    产品购买页
 */
@interface ServicePurchaseController : BaseViewController
<
    UITableViewDataSource,
    UITableViewDelegate
>
- (id)initWithProduct:(ProductModel *)product
          andWithType:(ProductTypeModel *)type
      andWithComboArr:(NSArray *)comboArr
      andWithDistrict:(DistrictModel *)district;

@property (nonatomic, strong) ProductModel *product;

@end