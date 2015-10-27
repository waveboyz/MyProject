//
//  PurchaseSecondCell.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"
#import "ProductModel.h"

@class ProductTypeModel;
@protocol PurchaseSecondCellDelegate <NSObject>

- (void)mathBtnPressedWithCount:(NSUInteger)count;

@optional
- (void)elevatorScreen;

@end

@interface PurchaseSecondCell : UITableViewCell
<
    UITextViewDelegate
>
@property (nonatomic, assign) id<PurchaseSecondCellDelegate> delegate;
@property (nonatomic, assign) ProductModel *product;
@property (nonatomic, assign) ProductTypeModel *type;
@property (nonatomic, retain) NSArray       *comboArr;
@property (nonatomic, assign) NSInteger     price;
@property (nonatomic, assign) NSUInteger    serviceCnt;
@property (nonatomic, strong) UITextView        *commentView;

@end