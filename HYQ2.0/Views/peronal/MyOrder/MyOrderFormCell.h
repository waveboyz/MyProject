//
//  MyOrderFormCell.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/13.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"
#import "OrderModel.h"

@protocol MyOrderFormCellDelegate <NSObject>

@optional
- (void)payBtnPressedWithOid:(NSNumber *)oid andWithIndexPath:(NSIndexPath *)indexPath;
- (void)evaluateBtnPressedWithOid:(NSNumber *)oid andWithIndexPath:(NSIndexPath *)indexPath;
- (void)confirmBtnPressedWithOid:(NSNumber *)oid andWithIndexPath:(NSIndexPath *)indexPath;
- (void)deleteBtnPressedWithOid:(NSNumber *)oid andWithIndexPath:(NSIndexPath *)indexPath;
- (void)purchaseBtnPressedWithOid:(NSNumber *)oid andWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface MyOrderFormCell : UITableViewCell

@property (nonatomic, assign) OrderModel *order;
@property (nonatomic, assign) id<MyOrderFormCellDelegate> delegate;
@property (nonatomic, assign) NSIndexPath   *indexPath;

@end