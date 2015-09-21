//
//  PurchaseSecondCell.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"
#import "ServiceModel.h"

@protocol PurchaseSecondCellDelegate <NSObject>

- (void)mathBtnPressedWithCount:(NSUInteger)count;

@optional
- (void)elevatorScreen;

@end

@interface PurchaseSecondCell : UITableViewCell
<
    UITextViewDelegate
>

@property (nonatomic, assign) ServiceModel *service;
@property (nonatomic, assign) NSUInteger    serviceCnt;
@property (nonatomic, assign) id<PurchaseSecondCellDelegate> delegate;
@property (nonatomic, strong) UITextView        *commentView;

@end