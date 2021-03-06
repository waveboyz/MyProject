//
//  ProductComboCell.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
    产品选择页套餐组合
 */
@class ProductTypeModel;
@protocol ProductComboCellDlegate <NSObject>

- (void)selectComboArrWith:(NSMutableArray *)comboArr;

@end
@interface ProductComboCell : UITableViewCell

@property (nonatomic, assign) ProductTypeModel *product;
@property (nonatomic, weak) id<ProductComboCellDlegate> delegate;

@end
