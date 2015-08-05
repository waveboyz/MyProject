//
//  CYBForgetPSWController.h
//  cyb
//
//  Created by JamHonyZ on 15/6/3.
//  Copyright (c) 2015年 huancheba. All rights reserved.
//

#import "BaseViewController.h"

@protocol HYQForgetPSWControllerDelegate <NSObject>

- (void)resetPasswordSuccess;

@end

@interface HYQForgetPSWController : BaseViewController
<
UITextFieldDelegate
>

@property (nonatomic,assign) id<HYQForgetPSWControllerDelegate> delegate;

@end
