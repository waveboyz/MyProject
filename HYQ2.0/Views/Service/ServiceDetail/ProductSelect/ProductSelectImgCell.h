//
//  ProductSelectImgCell.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
    产品选择页头cell
 */
@class ProductModel;
@class ProductTypeModel;
@class ProductComboModel;

@interface ProductSelectImgCell : UITableViewCell

@property (nonatomic, assign) ProductModel *product;
@property (nonatomic, assign) ProductTypeModel *type;
@property (nonatomic, retain) NSArray *comboArr;

@end
