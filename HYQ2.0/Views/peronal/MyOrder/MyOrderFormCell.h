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

- (void)payBtnPressedWithOid:(NSNumber *)oid;
- (void)evaluateBtnPressedWithOid:(NSNumber *)oid;
- (void)confirmBtnPressedWithOid:(NSNumber *)oid;

@end

@interface MyOrderFormCell : UITableViewCell

@property (nonatomic, assign) OrderModel *order;
@property (nonatomic, assign) id<MyOrderFormCellDelegate> delegate;

@end