//
//  OrderDetailCell.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/26.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"
#import "OrderModel.h"
/*
    产品详情cell
 */
@protocol OrderDetailCellDelegate <NSObject>

@optional
- (void)purchaseBtnTouched;
- (void)refundBtnTouched;

@end

@interface OrderDetailCell : UITableViewCell

@property (nonatomic, assign) OrderModel *order;
@property (nonatomic, weak) id<OrderDetailCellDelegate> delegate;

@end
