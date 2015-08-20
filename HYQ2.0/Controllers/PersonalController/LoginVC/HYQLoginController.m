//
//  CYBLoginController.m
//  cyb
//
//  Created by JamHonyZ on 15/5/28.
//  Copyright (c) 2015年 huancheba. All rights reserved.
//

#import "HYQLoginController.h"
#import "HYQRegisterController.h"
#import "AppDelegate.h"
#import "NSString+HCBStringHelper.h"

@interface HYQLoginController ()
{
    UITextField     *_phoneTxt;
    UITextField     *_codeTxt;
    UILabel         *_nameLbl;
    UILabel         *_codeLbl;
    UILabel         *_lineLbl;
    UILabel         *_lineLbl2;
    UILabel         *_registLbl;
    UIScrollView    *_bgView;
    UIButton        *_loginBtn;
    NSString        *_phoneNumber;
}
@end

@implementation HYQLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.5 animations:^(void){
        CGRect nameframe = _nameLbl.frame;
        nameframe.origin.x += 70;
        CGRect codeframe = _codeLbl.frame;
        codeframe.origin.x += 70;
        CGRect lineLblframe = _lineLbl.frame;
        lineLblframe.origin.x -= kScreenWidth - 15;
        CGRect lineLbl2frame = _lineLbl2.frame;
        lineLbl2frame.origin.x -= kScreenWidth - 15;
        CGRect registframe = _registLbl.frame;
        registframe.origin.y -= kScreenHeight - 358;
        
        [_nameLbl setFrame:nameframe];
        [_codeLbl setFrame:codeframe];
        [_lineLbl setFrame:lineLblframe];
        [_lineLbl2 setFrame:lineLbl2frame];
        [_registLbl setFrame:registframe];
    }];
    
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.3 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^(void){
        CGRect loginframe = _loginBtn.frame;
        loginframe.origin.y -= kScreenHeight - 308;
        [_loginBtn setFrame:loginframe];
    } completion:^(BOOL finished){}];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_nameLbl setFrame:CGRectMake(-50, 166, 50, 30)];
    [_codeLbl setFrame:CGRectMake(-50, 232, 50, 30)];
    [_lineLbl setFrame:CGRectMake(kScreenWidth, 206, kScreenWidth - 30, 1)];
    [_lineLbl2 setFrame:CGRectMake(kScreenWidth, 272, kScreenWidth - 30, 1)];
    [_loginBtn setFrame:CGRectMake(15, kScreenHeight, kScreenWidth - 30, 45)];
    [_registLbl setFrame:CGRectMake(kScreenWidth * 0.5 - 75, kScreenHeight + 20, 150, 20)];
}

- (void)creatUI
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgView.backgroundColor = NAVIBAR_GREEN_COLOR;
    [self.view addSubview:_bgView];
    
    UIImageView *btnImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_back"]];
    btnImg.frame = CGRectMake(15, 29.5, 18, 18);
    [self.view addSubview:btnImg];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 57, 57);
    [cancelBtn addTarget:self action:@selector(dismissLoginController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(-50, 166, 50, 30)];
    _nameLbl.textColor = [UIColor whiteColor];
    _nameLbl.font = [UIFont systemFontOfSize:13.0f];
    _nameLbl.text = @"手机号";
    [_bgView addSubview:_nameLbl];
    
    _phoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(60, 166, kScreenWidth - 80, 30)];
    _phoneTxt.textColor = [UIColor whiteColor];
    _phoneTxt.font = [UIFont systemFontOfSize:13.0f];
    _phoneTxt.keyboardType = UIKeyboardTypePhonePad;
    _phoneTxt.delegate = self;
    [_bgView addSubview:_phoneTxt];
    
    _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth, 206, kScreenWidth - 30, 1)];
    _lineLbl.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:_lineLbl];
    
    _codeLbl = [[UILabel alloc] initWithFrame:CGRectMake(-50, 232, 50, 30)];
    _codeLbl.textColor = [UIColor whiteColor];
    _codeLbl.font = [UIFont systemFontOfSize:13.0f];
    _codeLbl.text = @"密码";
    [_bgView addSubview:_codeLbl];
    
    _codeTxt = [[UITextField alloc] initWithFrame:CGRectMake(60, 232, kScreenWidth - 80, 30)];
    _codeTxt.textColor = [UIColor whiteColor];
    _codeTxt.font = [UIFont systemFontOfSize:13.0f];
    _codeTxt.secureTextEntry = YES;
    _codeTxt.delegate = self;
    _codeTxt.returnKeyType = UIReturnKeyGo;
    [_bgView addSubview:_codeTxt];
    
    _lineLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth, 272, kScreenWidth - 30, 1)];
    _lineLbl2.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:_lineLbl2];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(15, kScreenHeight, kScreenWidth - 30, 45);
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _loginBtn.alpha = 0.8;
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn setBackgroundColor:GRAY_COLOR];
    [_loginBtn addTarget:self action:@selector(startToLogin) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_loginBtn];
    
    _registLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 75, kScreenHeight + 20, 150, 20)];
    _registLbl.textAlignment = NSTextAlignmentCenter;
    _registLbl.font = [UIFont systemFontOfSize:12.0f];
    _registLbl.text = @"去注册账号";
    _registLbl.textColor = [UIColor whiteColor];
    [_bgView addSubview:_registLbl];
    _registLbl.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *regisTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushRegiterViewController)];
    [_registLbl addGestureRecognizer:regisTap];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapGes];
}

- (void)hideLoginBoard
{
    [[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)updateUserInformation:(NSDictionary *)userData
{
//    [[hcb_UserManager sharedUserManager] updateUserInfo:userData];
//    
//    if (self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(didLogin)]) {
//        [[self loginDelegate] didLogin];
//    }
}

- (void)didRegister:(NSNotification *)notification
{
    _phoneTxt.text = [[notification userInfo] objectForKey:@"username"];
    _codeTxt.text = [[notification userInfo] objectForKey:@"password"];
}

#pragma mark - UITextField Input Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _phoneTxt) {
        
        [_codeTxt becomeFirstResponder];
        
    } else if (textField == _codeTxt) {
        
        [textField resignFirstResponder];
        [self startToLogin];
        
    }
    return YES;
}

- (void)startToLogin
{
    NSString *usernameValue = _phoneTxt.text;
    NSString *passwordValue = _codeTxt.text;
    
    if (usernameValue && usernameValue.length > 0 && passwordValue && passwordValue.length > 0) {
        
        //  账号正则检测：3-20位ASCII字符
        NSString *nonemailRegex = @"^[a-zA-z0-9\u4E00-\u9FA5_@]+$";
        NSPredicate *nonemailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nonemailRegex];
        
        //  手机号正则检测
        NSString *mobileRegex = @"[1][34578][0-9]{9}";
        NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
        
        //  密码正则检测：密码不得少于六个字符
        NSString *pwdRegex = @"^.{6,20}$";
        NSPredicate *pwdPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdRegex];
        
        if (![pwdPredicate evaluateWithObject:passwordValue]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码不合法"
                                                            message:@"密码长度需在6-20个字符之间"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            alert.tag = 202;
            [alert show];
            
            return;
        }else if ((![nonemailPredicate evaluateWithObject:usernameValue]) && (![mobilePredicate evaluateWithObject:usernameValue])) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名不合法"
                                                            message:@"用户名长度需在3-20个字符之间"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            alert.tag = 201;
            [alert show];
            
            return;
        }else if ([mobilePredicate evaluateWithObject:usernameValue]){
            _phoneNumber = usernameValue;
            [self hideKeyboard];
            [self startLoginRequestOperation];
        }else if ([nonemailPredicate evaluateWithObject:usernameValue]){
            _phoneNumber = usernameValue;
            [self hideKeyboard];
            [self startLoginRequestOperation];
        }
    } else if (!usernameValue || usernameValue.length == 0) {
        
        [self showStateHudWithText:@"用户名不能为空"];
        
        [_phoneTxt becomeFirstResponder];
        return;
    } else if (!passwordValue || passwordValue.length == 0) {
        
        [self showStateHudWithText:@"密码不能为空"];
        
        [_codeTxt becomeFirstResponder];
        return;
    }
}

//字符长度检测
- (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

- (void)startLoginRequestOperation
{
    [self showStateHudWithText:@"正在登录..."];
}

#pragma mark - UIAlertView Delegation
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 201) {
        
        [_phoneTxt becomeFirstResponder];
        
    } else if (alertView.tag == 202) {
        
        [_codeTxt becomeFirstResponder];
        
    } else if (alertView.tag == 1000) {
        
    }
}

#pragma mark CYBLoginDelegate
- (void)UIDAlreadyLogin
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"账号已登录"
                                                    message:@"您的账号已在其它设备登录，请通过手机验证码在当前设备登录"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    alert.tag = 1000;
    [alert show];
}

- (void)loginWithWrongPsw
{
    [self performSelectorOnMainThread:@selector(hideHUDView) withObject:nil waitUntilDone:YES];
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"密码错误", @"title", nil, @"message", nil];
//    [self performSelectorOnMainThread:@selector(stateAlertTitle:) withObject:dict waitUntilDone:YES];
}

- (void)loginWithUserDict:(NSDictionary *)userDict;
{
    [self showStateHudWithText:@"登录成功"];
    [self updateUserInformation:userDict];
    [self performSelector:@selector(loginSuccess) withObject:nil afterDelay:0.5];
}

- (void)loginSuccess
{
    NSDictionary *userInfo = @{@"didLogin" : @"didLogin"};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didLogin" object:nil userInfo:userInfo];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
    
    userInfo = @{@"showMore" : @"showMore"};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didShowMoreVC" object:nil userInfo:userInfo];
}

- (void)hideHUDView
{
    [self.stateHud hide:YES afterDelay:0.2];
}

- (void)pushRegiterViewController
{
    HYQRegisterController *regisVC = [[HYQRegisterController alloc] init];
    [self presentViewController:regisVC animated:YES completion:^(void){}];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)dismissLoginController
{
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^(void){
        CGRect frame = _bgView.frame;
        frame.origin.y += 50;
        _bgView.contentOffset = CGPointMake(frame.origin.x, frame.origin.y);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^(void){
        _bgView.contentOffset = CGPointMake(0, 0);
    }];
}

#pragma mark CYBForgetPSWControllerDelegate
- (void)resetPasswordSuccess
{
    [_phoneTxt becomeFirstResponder];
}

@end