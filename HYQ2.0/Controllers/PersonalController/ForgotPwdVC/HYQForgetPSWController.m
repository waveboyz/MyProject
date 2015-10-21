//
//  CYBForgetPSWController.m
//  cyb
//
//  Created by JamHonyZ on 15/6/3.
//  Copyright (c) 2015年 huancheba. All rights reserved.
//

#import "HYQForgetPSWController.h"
#import "NSString+HCBStringHelper.h"
#import "HYQResetVerResponse.h"
#import "HYQResetResponse.h"

@interface HYQForgetPSWController ()
<
    HYQResetVerResponseDelegate,
    HYQResetResponseDelegate
>

@property (nonatomic, strong)       UITextField     *phoneTxt;
@property (nonatomic, strong)       UITextField     *codeTxt;
@property (nonatomic, strong)       UITextField     *resendTxt;
@property (nonatomic, strong)       UIButton        *getResendBtn;
@property (nonatomic, strong)       UIScrollView    *bgView;
@property (nonatomic, copy)         NSString        *phoneNum;
@property (nonatomic, strong)       NSTimer         *captchaTimer;
@property (nonatomic, assign)       NSInteger       reSendTime;

@end

@implementation HYQForgetPSWController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setViews];
}

- (void)setViews
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_bgView];
    
    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginBackImg"]];
    backImg.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [_bgView addSubview:backImg];
    
    UIImageView *btnImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_back"]];
    btnImg.frame = CGRectMake(15, 29.5, 18, 18);
    [self.view addSubview:btnImg];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 57, 57);
    [cancelBtn addTarget:self action:@selector(dismissLoginController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    //好园区Icon
    UIImageView *iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLOGO"]];
    iconImg.frame = CGRectMake(kScreenWidth * 0.5 - 50, 50, 100, 100);
    [_bgView addSubview:iconImg];
    
//    UILabel *phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 50, 30)];
//    phoneLbl.textColor = [UIColor whiteColor];
//    phoneLbl.font = [UIFont systemFontOfSize:13.0f];
//    phoneLbl.text = @"手机";
//    [_bgView addSubview:phoneLbl];
    
    //登录名描述
    UIImageView *phoneImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phoneIcon"]];
    phoneImg.frame = CGRectMake(20, 220, 15, 20);
    [_bgView addSubview:phoneImg];
    
    NSString *phonePlacholder = @"输入手机号";
    NSMutableAttributedString *phoneAttri = [[NSMutableAttributedString alloc] initWithString:phonePlacholder];
    [phoneAttri setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} range:NSMakeRange(0, phoneAttri.length)];
    
    _phoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(45, 215, kScreenWidth - 80, 30)];
    _phoneTxt.textColor = [UIColor whiteColor];
    _phoneTxt.font = [UIFont systemFontOfSize:15.0f];
    _phoneTxt.keyboardType = UIKeyboardTypePhonePad;
    _phoneTxt.delegate = self;
    _phoneTxt.attributedPlaceholder = phoneAttri;
    [_bgView addSubview:_phoneTxt];
    
    UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 250, kScreenWidth - 30, 1)];
    lineLbl.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:lineLbl];
//------------------------------------
    UIImageView *codeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeIcon"]];
    codeImg.frame = CGRectMake(20, 265, 15, 20);
    [_bgView addSubview:codeImg];
    
    NSString *codePlacholder = @"设置6-20位密码含数字字母";
    NSMutableAttributedString *codeAttri = [[NSMutableAttributedString alloc] initWithString:codePlacholder];
    [codeAttri setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} range:NSMakeRange(0, codeAttri.length)];
    
    _codeTxt = [[UITextField alloc] initWithFrame:CGRectMake(45, 260, kScreenWidth - 100, 30)];
    _codeTxt.textColor = [UIColor whiteColor];
    _codeTxt.font = [UIFont systemFontOfSize:13.0];
    _codeTxt.secureTextEntry = YES;
    _codeTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    _codeTxt.delegate = self;
    _codeTxt.attributedPlaceholder = codeAttri;
    [_bgView addSubview:_codeTxt];
    
    UILabel *lineLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 295, kScreenWidth - 30, 1)];
    lineLbl2.backgroundColor=[UIColor whiteColor];
    [_bgView addSubview:lineLbl2];
//-------------------------------------
    UIImageView *resendImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"resendIcon"]];
    resendImg.frame = CGRectMake(20, 310, 15, 20);
    [_bgView addSubview:resendImg];
    
    NSString *resendPlacholder = @"输入验证码";
    NSMutableAttributedString *resendAttri = [[NSMutableAttributedString alloc] initWithString:resendPlacholder];
    [resendAttri setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} range:NSMakeRange(0, resendAttri.length)];
    
    _resendTxt = [[UITextField alloc] initWithFrame:CGRectMake(45, 305, kScreenWidth * 0.5 - 15, 30)];
    _resendTxt.textColor = [UIColor whiteColor];
    _resendTxt.font = [UIFont systemFontOfSize:15.0f];
    _resendTxt.keyboardType = UIKeyboardTypeNumberPad;
    _resendTxt.delegate = self;
    _resendTxt.attributedPlaceholder = resendAttri;
    [_bgView addSubview:_resendTxt];
    
    UILabel *lineLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 340, kScreenWidth - 30, 1)];
    lineLbl3.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:lineLbl3];
    
    _getResendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getResendBtn.frame = CGRectMake(kScreenWidth - 105, 310, 90, 25);
    _getResendBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _getResendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _getResendBtn.layer.cornerRadius = CGRectGetWidth(_getResendBtn.frame) / 32;
    _getResendBtn.alpha = 0.8;
    [_getResendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getResendBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
    [_getResendBtn setBackgroundColor:[UIColor whiteColor]];
    [_getResendBtn addTarget:self action:@selector(sendVerCodeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_getResendBtn];
//----------------------------------
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(15, 375, kScreenWidth - 30, 45);
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    confirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    confirmBtn.alpha = 0.8;
    confirmBtn.layer.cornerRadius = CGRectGetWidth(confirmBtn.frame) /32;
    [confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor whiteColor]];
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

- (void)dismissLoginController
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
    [UIView animateWithDuration:0.2 animations:^(void){
        _bgView.contentOffset = CGPointMake(0, 0);}];
}

- (void)submitReg
{
    NSString *passwordValue = _codeTxt.text;
    NSString *phoneNumValue = _phoneTxt.text;
    NSString *verifyCodeValue = _resendTxt.text;
    
    if (passwordValue && passwordValue.length > 0 && phoneNumValue && phoneNumValue.length > 0 && verifyCodeValue && verifyCodeValue.length > 0) {
        
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
            alert.tag = 201;
            [alert show];
            
            return;
            
        } else if (![mobilePredicate evaluateWithObject:phoneNumValue]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入正确的手机号码"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            alert.tag = 202;
            [alert show];
            
            return;
            
        } else if (![verCodePredicate evaluateWithObject:verifyCodeValue]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码有误"
                                                            message:@"验证码为四位数字"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            alert.tag = 203;
            [alert show];
            
            return;
            
        }  else {
            [self resignFirstResponder];
            
            [self showNoTextStateHud];
            
            self.stateHud.labelText = @"正在提交..";
            
            [self resetPwdOperation];
        }
    } else if (!passwordValue || passwordValue.length == 0) {
        
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

#pragma mark - resetPwdRequest
- (void)resetPwdOperation
{
    HYQResetResponse *response = [[HYQResetResponse alloc] initWithPhone:_phoneTxt.text
                                                              andWithPsw:_codeTxt.text.md5
                                                          andWithVerCode:_resendTxt.text];
    response.delegate = self;
    [response start];
}

//验证码发送
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
    
    [_resendTxt becomeFirstResponder];
    [self sendVerCodeRequestOperation];
}

- (void)sendVerCodeRequestOperation
{
    HYQResetVerResponse *response = [[HYQResetVerResponse alloc] initWithPhone:_phoneTxt.text];
    response.delegate = self;
    [response start];

    _getResendBtn.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    [_getResendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getResendBtn setTitle:@"120s 重新获取" forState:UIControlStateNormal];
    _getResendBtn.enabled = NO;
    _reSendTime = 120;
    
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
        [_getResendBtn setBackgroundColor:GRAY_COLOR];
        [_getResendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getResendBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
        [_getResendBtn setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.6] forState:UIControlStateHighlighted];
        
        _getResendBtn.enabled = YES;
        _captchaTimer = nil;
    }
}

#pragma mark HYQResetVerResponseDelegate
- (void)sendVerCodeSucceed
{
    [self stopStateHud];
    [self showStateHudWithText:@"验证码发送成功"];
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self showStateHudWithText:text];
}

#pragma mark HYQResetResponseDelegate
- (void)resetPswSucceed
{
    [self stopStateHud];
    [self showStateHudWithText:@"密码重设成功！"];
    [self performSelector:@selector(dismissSelf) withObject:nil afterDelay:1.5];
}

#pragma mark - UIAlertView Delegation
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 201) {
        
        [_codeTxt becomeFirstResponder];
        
    } else if (alertView.tag == 202) {
        
        [_phoneTxt becomeFirstResponder];
        
    } else if (alertView.tag == 203) {
        
        [_resendTxt becomeFirstResponder];
        
    }
}

- (void)dismissSelf
{
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

@end