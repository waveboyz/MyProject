//
//  CYBLoginController.m
//  cyb
//
//  Created by JamHonyZ on 15/5/28.
//  Copyright (c) 2015年 huancheba. All rights reserved.
//

#import "HYQLoginController.h"
#import "HYQRegisterController.h"
#import "HYQForgetPSWController.h"
#import "AppDelegate.h"
#import "NSString+HCBStringHelper.h"
#import "HYQLoginResponse.h"
#import "HYQUserManager.h"

#define LINEGREEN     [UIColor colorWithRed:14/255 green:129/255 blue:74/255 alpha:1]
#define LINEWHITE     [UIColor colorWithRed:47/255 green:215/255 blue:135/255 alpha:1]
@interface HYQLoginController ()
<
    HYQLoginResponseDelegate
>

@property (nonatomic, strong)    UITextField     *phoneTxt;
@property (nonatomic, strong)    UITextField     *codeTxt;
@property (nonatomic, strong)    UIScrollView    *bgView;
//@property (nonatomic, strong)    UILabel         *nameLbl;
//@property (nonatomic, strong)    UILabel         *codeLbl;
//@property (nonatomic, strong)    UILabel         *lineLbl;
//@property (nonatomic, strong)    UILabel         *lineLbl2;
@property (nonatomic, strong)    UIButton         *resetPWDLbl;
@property (nonatomic, strong)    UIButton        *loginBtn;
@property (nonatomic, strong)    UIButton        *registLbl;
@property (nonatomic, copy)      NSString        *phoneNumber;

@end

@implementation HYQLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatUI];

}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    [UIView animateWithDuration:0.5 animations:^(void){
//        CGRect nameframe = _nameLbl.frame;
//        nameframe.origin.x += 70;
//        CGRect codeframe = _codeLbl.frame;
//        codeframe.origin.x += 70;
//        CGRect lineLblframe = _lineLbl.frame;
//        lineLblframe.origin.x -= kScreenWidth - 15;
//        CGRect lineLbl2frame = _lineLbl2.frame;
//        lineLbl2frame.origin.x -= kScreenWidth - 15;
//        
//        [_nameLbl setFrame:nameframe];
//        [_codeLbl setFrame:codeframe];
//        [_lineLbl setFrame:lineLblframe];
//        [_lineLbl2 setFrame:lineLbl2frame];
//    }];
//    
//    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.3 initialSpringVelocity:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^(void){
//        CGRect loginframe = _loginBtn.frame;
//        CGRect resetframe = _resetPWDLbl.frame;
//        loginframe.origin.y -= kScreenHeight - 308;
//        resetframe.origin.y -= kScreenHeight - 308;
//        [_loginBtn setFrame:loginframe];
//        [_resetPWDLbl setFrame:resetframe];
//    } completion:^(BOOL finished){}];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [_nameLbl setFrame:CGRectMake(-50, 166, 50, 30)];
//    [_codeLbl setFrame:CGRectMake(-50, 232, 50, 30)];
//    [_lineLbl setFrame:CGRectMake(kScreenWidth, 206, kScreenWidth - 30, 1)];
//    [_lineLbl2 setFrame:CGRectMake(kScreenWidth, 272, kScreenWidth - 30, 1)];
//    [_loginBtn setFrame:CGRectMake(15, kScreenHeight, kScreenWidth - 30, 45)];
//    [_resetPWDLbl setFrame:CGRectMake(kScreenWidth - 135, kScreenHeight + 60, 120, 20)];
//}

- (void)creatUI
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_bgView];
    
    //背景图片
    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginBackImg"]];
    backImg.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [_bgView addSubview:backImg];
    
    //返回图像
    UIImageView *btnImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_back"]];
    btnImg.frame = CGRectMake(15, 29.5, 18, 18);
    [self.view addSubview:btnImg];
    
    //返回按钮，用于增大触发面积
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 57, 57);
    [cancelBtn addTarget:self action:@selector(dissmissLoginController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    //好园区Icon
    UIImageView *iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLOGO"]];
    iconImg.frame = CGRectMake(kScreenWidth * 0.5 - 50, 50, 100, 100);
    [_bgView addSubview:iconImg];
    
    //登录名描述
    UIImageView *phoneImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phoneIcon"]];
    phoneImg.frame = CGRectMake(20, 176, 15, 20);
    [_bgView addSubview:phoneImg];
    
    //登录名输入
    NSString *phonePlacholder = @"输入手机号";
    NSMutableAttributedString *phoneAttri = [[NSMutableAttributedString alloc] initWithString:phonePlacholder];
    [phoneAttri setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} range:NSMakeRange(0, phoneAttri.length)];
    _phoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(45, 171, kScreenWidth - 80, 30)];
    _phoneTxt.textColor = [UIColor whiteColor];
    _phoneTxt.font = [UIFont systemFontOfSize:15.0f];
    _phoneTxt.keyboardType = UIKeyboardTypePhonePad;
    _phoneTxt.delegate = self;
    _phoneTxt.attributedPlaceholder = phoneAttri;
    [_bgView addSubview:_phoneTxt];
    
    //------------
    UILabel *lineLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 206, kScreenWidth - 30, 0.25)];
    lineLbl1.backgroundColor = LINEGREEN;
    [_bgView addSubview:lineLbl1];
    UILabel *lineLbl2 =[[UILabel alloc] initWithFrame:CGRectMake(15, 206.25, kScreenWidth - 30, 0.25)];
    lineLbl2.backgroundColor = LINEWHITE;
    [_bgView addSubview:lineLbl2];
    
    //密码描述
    UIImageView *codeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeIcon"]];
    codeImg.frame = CGRectMake(20, 242, 15, 20);
    [_bgView addSubview:codeImg];
    
    //密码输入
    NSString *codePlacholder = @"输入密码";
    NSMutableAttributedString *codeAttri = [[NSMutableAttributedString alloc] initWithString:codePlacholder];
    [codeAttri setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} range:NSMakeRange(0, codeAttri.length)];
    _codeTxt = [[UITextField alloc] initWithFrame:CGRectMake(45, 237, kScreenWidth - 80, 30)];
    _codeTxt.textColor = [UIColor whiteColor];
    _codeTxt.font = [UIFont systemFontOfSize:15.0f];
    _codeTxt.secureTextEntry = YES;
    _codeTxt.delegate = self;
    _codeTxt.returnKeyType = UIReturnKeyGo;
    _codeTxt.attributedPlaceholder = codeAttri;
    [_bgView addSubview:_codeTxt];
    
    //---------
    UILabel *lineLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 272, kScreenWidth - 30, 0.25)];
    lineLbl3.backgroundColor = LINEGREEN;
    [_bgView addSubview:lineLbl3];
    UILabel *lineLbl4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 272.25, kScreenWidth - 30, 0.25)];
    lineLbl4.backgroundColor = LINEWHITE;
    [_bgView addSubview:lineLbl4];
    
    //登陆按钮
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(15, 308, kScreenWidth - 30, 45);
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _loginBtn.layer.cornerRadius = CGRectGetWidth(_loginBtn.frame) / 32;
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
    [_loginBtn setBackgroundColor:[UIColor whiteColor]];
    [_loginBtn addTarget:self action:@selector(startToLogin) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_loginBtn];
    
    //注册按钮
    _registLbl = [UIButton buttonWithType:UIButtonTypeCustom];
    _registLbl.frame = CGRectMake(15, 376, 150, 20);
    _registLbl.titleLabel.textAlignment = NSTextAlignmentLeft;
    _registLbl.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [_registLbl setTitle:@"没有账号？点这注册" forState:UIControlStateNormal];
    [_registLbl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registLbl addTarget:self action:@selector(pushRegiterViewController) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_registLbl];
    
    //找回密码
    _resetPWDLbl = [UIButton buttonWithType:UIButtonTypeCustom];
    _resetPWDLbl.frame = CGRectMake(kScreenWidth - 135, 376, 120, 20);
    [_resetPWDLbl setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_resetPWDLbl setTitle:@"忘记密码？" forState:UIControlStateNormal];
    _resetPWDLbl.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [_resetPWDLbl addTarget:self action:@selector(resetPWDPressed) forControlEvents:UIControlEventTouchUpInside];
    _resetPWDLbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_bgView addSubview:_resetPWDLbl];
    
    //隐藏键盘手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapGes];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)dissmissLoginController
{
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

//找回密码入口
- (void)resetPWDPressed
{
    HYQForgetPSWController *forgetVC = [[HYQForgetPSWController alloc] init];
    [self presentViewController:forgetVC animated:YES completion:^(void){}];
}

//注册入口
- (void)pushRegiterViewController
{
    HYQRegisterController *regisVC = [[HYQRegisterController alloc] init];
    [self presentViewController:regisVC animated:YES completion:^(void){}];
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

//验证登陆
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

//登陆请求
- (void)startLoginRequestOperation
{
    [self showNoTextStateHud];
    HYQLoginResponse *response = [[HYQLoginResponse alloc] initWithPhoneNumber:_phoneTxt.text andWithPassWord:_codeTxt.text.md5];
    response.delegate = self;
    [response start];
}

//更新本地用户信息
- (void)updateUserInformation:(NSDictionary *)userData
{
    [[HYQUserManager sharedUserManager] updateUserInfo:userData];
}

#pragma mark HYQLoginReponseDelegate
- (void)getResponseDictionary:(NSDictionary *)dictionary
{
    [self stopStateHud];
    [self showStateHudWithText:@"登录成功"];
    [self performSelectorOnMainThread:@selector(updateUserInformation:) withObject:dictionary waitUntilDone:YES];
    [self performSelector:@selector(loginSuccess) withObject:nil afterDelay:0.5];
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self showStateHudWithText:text];
}

- (void)loginSuccess
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didLogin" object:nil];
    
    [self dissmissLoginController];
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

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 201) {
        
        [_phoneTxt becomeFirstResponder];
        
    } else if (alertView.tag == 202) {
        
        [_codeTxt becomeFirstResponder];
        
    } else if (alertView.tag == 1000) {
        
    }
}

@end