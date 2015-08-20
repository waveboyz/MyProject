//
//  CYBRegisterController.m
//  cyb
//
//  Created by JamHonyZ on 15/6/3.
//  Copyright (c) 2015年 huancheba. All rights reserved.
//

#import "HYQRegisterController.h"
#import "HYQLoginController.h"
#import "AppDelegate.h"
#import "NSString+HCBStringHelper.h"

#define MOBILENUMBER                    @"0123456789"

@interface HYQRegisterController()
{
    UITextField     *_phoneTxt;
    UITextField     *_codeTxt;
    UITextField     *_resendTxt;
    UIButton        *_getResendBtn;
    UIScrollView    *_bgView;
    NSTimer         *_captchaTimer;
    NSInteger       _reSendTime;
    NSString        *_userName;
    NSString        *_pswMD5;
    NSString        *_uid;
}
@end

@implementation HYQRegisterController

- (void)hideRegisterBoard
{
    [[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setViews];
}

- (void)setViews
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = BG_GRAY_COLOR;
    _bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [_bgView setBackgroundColor:NAVIBAR_GREEN_COLOR];
    [self.view addSubview:_bgView];
    
    UIImageView *btnImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_back"]];
    btnImg.frame = CGRectMake(15, 29.5, 18, 18);
    [self.view addSubview:btnImg];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 57, 57);
    [cancelBtn addTarget:self action:@selector(dismissRegisterController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    UILabel *phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 50, 30)];
    phoneLbl.textColor = [UIColor whiteColor];
    phoneLbl.font = [UIFont systemFontOfSize:13.0f];
    phoneLbl.text = @"手机";
    [_bgView addSubview:phoneLbl];
    
    _phoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(60, 170, kScreenWidth - 80, 30)];
    _phoneTxt.textColor = [UIColor whiteColor];
    _phoneTxt.font = [UIFont systemFontOfSize:13.0f];
    _phoneTxt.keyboardType = UIKeyboardTypePhonePad;
    _phoneTxt.delegate = self;
    [_bgView addSubview:_phoneTxt];
    
    UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 210, kScreenWidth - 30, 1)];
    lineLbl.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:lineLbl];
    
    UILabel *newCode = [[UILabel alloc] initWithFrame:CGRectMake(20, 226, 50, 30)];
    newCode.textColor = [UIColor whiteColor];
    newCode.font = [UIFont systemFontOfSize:13.0f];
    newCode.text = @"密码";
    [_bgView addSubview:newCode];
    
    _codeTxt = [[UITextField alloc] initWithFrame:CGRectMake(60, 226, kScreenWidth - 80, 30)];
    _codeTxt.textColor = [UIColor whiteColor];
    _codeTxt.font = [UIFont systemFontOfSize:13.0];
    _codeTxt.secureTextEntry = YES;
    _codeTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    _codeTxt.delegate = self;
    [_bgView addSubview:_codeTxt];
    
    UILabel *lineLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 266, kScreenWidth - 30, 1)];
    lineLbl2.backgroundColor=[UIColor whiteColor];
    [_bgView addSubview:lineLbl2];
    
    
    UILabel *reSendLbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 286, 70, 30)];
    reSendLbl.textColor = [UIColor whiteColor];
    reSendLbl.font = [UIFont systemFontOfSize:13.0f];
    reSendLbl.text = @"验证码";
    [_bgView addSubview:reSendLbl];
    
    _resendTxt = [[UITextField alloc] initWithFrame:CGRectMake(80, 286, kScreenWidth * 0.5 - 15, 30)];
    _resendTxt.textColor = [UIColor whiteColor];
    _resendTxt.font = [UIFont systemFontOfSize:13.0];
    _resendTxt.keyboardType = UIKeyboardTypeNumberPad;
    _resendTxt.delegate = self;
    [_bgView addSubview:_resendTxt];
    
    UILabel *lineLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 322, kScreenWidth * 0.5 - 15, 1)];
    lineLbl3.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:lineLbl3];
    
    _getResendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getResendBtn.frame = CGRectMake(CGRectGetMaxX(lineLbl3.frame), 267, kScreenWidth * 0.5 - 15, 55);
    _getResendBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _getResendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _getResendBtn.alpha = 0.8;
    [_getResendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getResendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getResendBtn setBackgroundImage:[UIImage imageNamed:@"loginIcon"] forState:UIControlStateNormal];
    [_getResendBtn addTarget:self action:@selector(sendVerCodeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_getResendBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(15, 357, kScreenWidth - 30, 45);
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    confirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    confirmBtn.alpha = 0.8;
    [confirmBtn setTitle:@"注册" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"loginIcon"] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(submitReg) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:confirmBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void)dismissRegisterController
{
    [self dismissViewControllerAnimated:YES completion:^(void){}];
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
    [UIView animateWithDuration:0.2 animations:^(void){    _bgView.contentOffset = CGPointMake(0, 0);}];
}

- (void)submitReg
{
    NSString *passwordValue = _codeTxt.text;
    NSString *phoneNumValue = _phoneTxt.text;
    NSString *verifyCodeValue = _resendTxt.text;
    
    if (passwordValue && passwordValue.length > 0 && phoneNumValue && phoneNumValue.length > 0 && verifyCodeValue && verifyCodeValue.length > 0)
    {
        
//        //  账号正则检测：账号在2-14个字符之间
//        NSString *usernameRegex = @"^.{2,14}$";
//        NSPredicate *usernamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", usernameRegex];
        
        //  密码正则检测：密码不得少于六个字符
        NSString *pwdRegex = @"^.{6,20}$";
        NSPredicate *pwdPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdRegex];
        
        //  手机号正则
        NSString *mobileRegex = @"[1][34578][0-9]{9}";
        NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
        
        //  验证码正则
        NSString    *verCodeRegex     = @"[0-9]{4}";
        NSPredicate *verCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verCodeRegex];
        
        if (![pwdPredicate evaluateWithObject:passwordValue]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码不合法"
                                                            message:@"密码长度需在6-20个字符之间"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            alert.tag = 202;
            [alert show];
            
            return;
            
        } else if (![mobilePredicate evaluateWithObject:phoneNumValue]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入正确的手机号码"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            alert.tag = 203;
            [alert show];
            
            return;
            
        } else if (![verCodePredicate evaluateWithObject:verifyCodeValue]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码有误"
                                                            message:@"验证码为四位数字"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            alert.tag = 204;
            [alert show];
            
            return;
            
        } else {
            
            [self resignFirstResponder];
            
            [self showNoTextStateHud];
            
            self.stateHud.labelText = @"正在提交..";
            
            [self registerOperation];
        }
    }

    else if (!passwordValue || passwordValue.length == 0) {
        
        [self showStateHudWithText:@"密码不能为空"];
        [_codeTxt becomeFirstResponder];
        
        return;
    } else if (!phoneNumValue || phoneNumValue.length == 0) {
        
        [self showStateHudWithText:@"手机号码不能为空"];
        [_phoneTxt becomeFirstResponder];
        
        return;
    } else if (!verifyCodeValue || verifyCodeValue.length == 0) {
        
        [self showStateHudWithText:@"验证码不能为空"];
        [_resendTxt becomeFirstResponder];
        
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

#pragma mark - registerRequest
- (void)registerOperation
{
    _userName = _phoneTxt.text;
    _pswMD5   = _codeTxt.text.md5;
}

- (void)hideHUDView
{
    [self.stateHud hide:YES afterDelay:0.2];
}

- (void)sendVerCodeButtonPressed
{
    NSString *mobileRegex = @"[1][34578][0-9]{9}";
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    
    if (![mobilePredicate evaluateWithObject:_phoneTxt.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入正确的手机号码"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        alert.tag = 204;
        [alert show];
        
        return;
    }
    
    [self sendVerCodeRequestOperation];
}

- (void)sendVerCodeRequestOperation
{
    _getResendBtn.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    [_getResendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getResendBtn setTitle:@"60s 重新获取" forState:UIControlStateNormal];
    _getResendBtn.enabled = NO;
    _reSendTime = 60;
    
    _captchaTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                     target:self
                                                   selector:@selector(updateReSendTime:)
                                                   userInfo:nil
                                                    repeats:YES];
}

- (void)updateReSendTime:(NSTimer *)timer
{
    _reSendTime -= 1;
    
    if (_reSendTime >= 0) {
        [_getResendBtn setTitle:[NSString stringWithFormat:@"%lds 重新获取", _reSendTime] forState:UIControlStateNormal];
    } else {
        [_getResendBtn setBackgroundColor:BLUE_COLOR];
        [_getResendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getResendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_getResendBtn setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.6] forState:UIControlStateHighlighted];
        
        _getResendBtn.enabled = YES;
        _captchaTimer = nil;
    }
}

#pragma mark - sendVerCode Delegate
- (void)sendVerCodeFailed
{
    [self performSelectorOnMainThread:@selector(hideHUDView) withObject:nil waitUntilDone:YES];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"提示", @"title", @"网络错误", @"message", nil];
//    [self performSelectorOnMainThread:@selector(stateAlertTitle:) withObject:dict waitUntilDone:YES];
}

#pragma mark - UITextField Input Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _phoneTxt) {
        
        [_codeTxt becomeFirstResponder];
        
    } else if (textField == _codeTxt) {
        
        [_resendTxt becomeFirstResponder];
        
    } else if (textField == _resendTxt) {
        
        [textField resignFirstResponder];
        [self submitReg];
    }
    return YES;
}

#pragma mark - UIAlertView Delegation
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 201) {
        
        [_phoneTxt becomeFirstResponder];
        
    } else if (alertView.tag == 202) {
        
        [_codeTxt becomeFirstResponder];
        
    } else if (alertView.tag == 203) {
        
        [_phoneTxt becomeFirstResponder];
        
    } else if (alertView.tag == 204) {
        
        [_resendTxt becomeFirstResponder];
        
    }
}

- (void)phoneNumberAlreadyRegistered
{
    _phoneTxt.textColor = [UIColor redColor];
    
    [_phoneTxt becomeFirstResponder];
}

- (void)verCodeMisTyped
{
    _resendTxt.textColor = [UIColor redColor];
    
    [_resendTxt becomeFirstResponder];
}

@end
