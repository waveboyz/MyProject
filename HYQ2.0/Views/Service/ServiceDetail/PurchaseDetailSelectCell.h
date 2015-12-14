//
//  PurchaseDetailSelectCell.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/19.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
    购买组合选择
 */
@class ProductComboModel;
@class ProductTypeModel;
@interface PurchaseDetailSelectCell : UITableViewCell

@property (nonatomic, assign) ProductTypeModel *type;
@property (nonatomic, retain) NSArray   *comboArr;

@end
