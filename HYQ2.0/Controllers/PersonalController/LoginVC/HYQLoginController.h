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
- (void)hideLoginBoard;
- (void)updateUserInformation:(NSDictionary *)userData;
- (void)didRegister:(NSNotification *)notification;

@end
