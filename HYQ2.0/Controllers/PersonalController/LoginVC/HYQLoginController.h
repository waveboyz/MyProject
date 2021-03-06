//
//  CYBLoginController.h
//  cyb
//
//  Created by JamHonyZ on 15/5/28.
//  Copyright (c) 2015年 huancheba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "GlobalConst.h"
/*
 注册
 */

@protocol LoginDelegate <NSObject>

@optional

- (void)didLogin;

@end

@interface HYQLoginController : BaseViewController
<
UITextFieldDelegate,
UIAlertViewDelegate
>

@property (nonatomic,assign) id<LoginDelegate>loginDelegate;
- (void)startToLogin;
- (void)updateUserInformation:(NSDictionary *)userData;

@end
