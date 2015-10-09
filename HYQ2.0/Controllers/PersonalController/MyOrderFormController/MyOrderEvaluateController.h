//
//  MyOrderEvaluateController.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
/*
    评价订单
 */
@protocol MyOrderEvaluateControllerDelegate <NSObject>

- (void)evaluateSucceed;

@end

@interface MyOrderEvaluateController : BaseViewController

@property (nonatomic, weak) id<MyOrderEvaluateControllerDelegate> delegate;
- (id)initWithOid:(NSNumber *)oid andWithSettleID:(NSNumber *)settleID;

@end
