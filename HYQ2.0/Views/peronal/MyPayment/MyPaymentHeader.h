//
//  MyPaymentHeader.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"

@protocol MyPaymenyHeaderDelegate <NSObject>

@end

@interface MyPaymentHeader : UIView

@property (nonatomic,assign) id<MyPaymenyHeaderDelegate> delegate;

@end
