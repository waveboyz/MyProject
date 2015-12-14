//
//  RefundSecondCell.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/27.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
    订单详情第二cell
 */
@protocol RefundSecondCellDelegate <NSObject>

@optional
- (void)selectReasonsWith:(NSArray *)reasons;

@end

@interface RefundSecondCell : UITableViewCell

@property (nonatomic, weak) id<RefundSecondCellDelegate> delegate;

@end