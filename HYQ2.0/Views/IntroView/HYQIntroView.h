//
//  HYQIntroView.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/21.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"

@protocol HYQIntroViewDelegate <NSObject>

-(void)onDoneButtonPressed;

@end

@interface HYQIntroView : UIView
<
    UIScrollViewDelegate
>

@property id<HYQIntroViewDelegate> delegate;

@end
