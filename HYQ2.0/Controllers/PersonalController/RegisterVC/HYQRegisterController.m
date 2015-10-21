//
//  HYQRegisterController.m
//  HYQ
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "HYQRegisterController.h"
#import "AppDelegate.h"
#import "HYQLoginController.h"
#import "InfoWebViewController.h"
#import "NSString+HCBStringHelper.h"
#import "HYQSendVerCodeResponse.h"
#import "HYQRegistResponse.h"

#define MOBILENUMBER                    @"0123456789"
#define LINEGREEN     [UIColor colorWithRed:14/255 green:129/255 blue:74/255 alpha:1]
#define LINEWHITE     [UIColor colorWithRed:47/255 green:215/255 blue:135/255 alpha:1]

@interface HYQRegisterController()
<
    HYQSendVerCodeResponseDelegate,
    HYQRegistResponseDelegate,
    UIAlertViewDelegate
>
@property (nonatomic, strong)    UITextField     *phoneTxt;         //注册手机
@property (nonatomic, strong)    UITextField     *codeTxt;          //密码
@property (nonatomic, strong)    UITextField     *resendTxt;        //验证码
@property (nonatomic, strong)    UITextField     *suggestTxt;       //推荐人手机
@property (nonatomic, strong)    UITextField     *repeatTxt;        //重复输入密码
@property (nonatomic, strong)    UIButton        *getResendBtn;     //获取验证码
@property (nonatomic, strong)    UIButton        *selecBtn;         //阅读协议按钮
@property (nonatomic, strong)    UIScrollView    *bgView;
@property (nonatomic, strong)    NSTimer         *captchaTimer;
@property (nonatomic, assign)    NSInteger       reSendTime;
@property (nonatomic, copy)      NSString        *phone;
@property (nonatomic, copy)      NSString        *pswMD5;
@property (nonatomic, copy)      NSString        *verCode;
@property (nonatomic, copy)      NSString        *uid;
@property (nonatomic, copy)      NSString        *sugPhone;
@property (nonatomic, assign)    BOOL            IS_QRSCAN;

@end

@implementation HYQRegisterController

- (void)hideRegisterBoard
{
    [[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (id)init
{
    if (self = [super init]) {
        _IS_QRSCAN = NO;
    }
    
    return self;
}

- (id)initWithSuggestNumber:(NSString *)suggestNum
{
    if (self = [super init]) {
        _sugPhone = suggestNum;
        _IS_QRSCAN = YES;
    }
    
    return self;
}

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
    
    //背景图片
    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginBackImg"]];
    backImg.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [_bgView addSubview:backImg];
    
    //返回按钮
    UIImageView *btnImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_back"]];
    btnImg.frame = CGRectMake(15, 29.5, 18, 18);
    [self.view addSubview:btnImg];
    //增加触控面积
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 57, 57);
    [cancelBtn addTarget:self action:@selector(dismissRegisterController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    //好园区Icon
    UIImageView *iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconLOGO"]];
    iconImg.frame = CGRectMake(kScreenWidth * 0.5 - 50, 50, 100, 100);
    [_bgView addSubview:iconImg];
//----------------------------------------------
    UIImageView *phoneImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phoneIcon"]];
    phoneImg.frame = CGRectMake(20, 170, 15, 20);
    [_bgView addSubview:phoneImg];
    
    NSString *phonePlaceholde = @"输入手机号";
    NSMutableAttributedString *phoneAttri = [[NSMutableAttributedString alloc] initWithString:phonePlaceholde];
    [phoneAttri setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} range:NSMakeRange(0, phoneAttri.length)];
    
    _phoneTxt = [[UITextField alloc] initWithFrame:CGRectMake(45, 165, kScreenWidth - 80, 30)];
    _phoneTxt.textColor = [UIColor whiteColor];
    _phoneTxt.font = [UIFont systemFontOfSize:15.0f];
    _phoneTxt.keyboardType = UIKeyboardTypePhonePad;
    _phoneTxt.delegate = self;
    _phoneTxt.attributedPlaceholder = phoneAttri;
    [_bgView addSubview:_phoneTxt];
    
    UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 200, kScreenWidth - 30, 0.25)];
    lineLbl.backgroundColor = LINEGREEN;
    [_bgView addSubview:lineLbl];
    
    UILabel *lineLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 200.25, kScreenWidth - 30, 0.25)];
    lineLbl1.backgroundColor = LINEWHITE;
    [_bgView addSubview:lineLbl1];
    
    //----------------------------------------------
    UIImageView *reSendImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"resendIcon"]];
    reSendImg.frame = CGRectMake(20, 220, 15, 20);
    [_bgView addSubview:reSendImg];
    
    NSString *resendPlaceholde = @"输入手机验证码";
    NSMutableAttributedString *resendAttri = [[NSMutableAttributedString alloc] initWithString:resendPlaceholde];
    [resendAttri setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} range:NSMakeRange(0, resendAttri.length)];
    
    _resendTxt = [[UITextField alloc] initWithFrame:CGRectMake(45, 215, kScreenWidth * 0.5 - 15, 30)];
    _resendTxt.textColor = [UIColor whiteColor];
    _resendTxt.font = [UIFont systemFontOfSize:15.0f];
    _resendTxt.keyboardType = UIKeyboardTypeNumberPad;
    _resendTxt.delegate = self;
    _resendTxt.attributedPlaceholder = resendAttri;
    [_bgView addSubview:_resendTxt];
    
    UILabel *lineLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 250, kScreenWidth - 30, 0.25)];
    lineLbl2.backgroundColor = LINEGREEN;
    [_bgView addSubview:lineLbl2];
    
    UILabel *lineLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 250.25, kScreenWidth - 30, 0.25)];
    lineLbl3.backgroundColor = LINEWHITE;
    [_bgView addSubview:lineLbl3];
    
    _getResendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getResendBtn.frame = CGRectMake(kScreenWidth - 105, 215, 90, 25);
    _getResendBtn.alpha = 0.8;
    _getResendBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _getResendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _getResendBtn.layer.cornerRadius = CGRectGetWidth(_getResendBtn.frame) / 32;
    [_getResendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getResendBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
    [_getResendBtn setBackgroundColor:[UIColor whiteColor]];
    [_getResendBtn addTarget:self action:@selector(sendVerCodeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_getResendBtn];
    //----------------------------------------------
    UIImageView *codeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeIcon"]];
    codeImg.frame = CGRectMake(20, 270, 15, 20);
    [_bgView addSubview:codeImg];
    
    NSString *codePlaceholde = @"设置6-20位密码含数字字母";
    NSMutableAttributedString *codeAttri = [[NSMutableAttributedString alloc] initWithString:codePlaceholde];
    [codeAttri setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} range:NSMakeRange(0, codeAttri.length)];
    
    _codeTxt = [[UITextField alloc] initWithFrame:CGRectMake(45, 265, kScreenWidth - 80, 30)];
    _codeTxt.textColor = [UIColor whiteColor];
    _codeTxt.font = [UIFont systemFontOfSize:15.0f];
    _codeTxt.secureTextEntry = YES;
    _codeTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    _codeTxt.delegate = self;
    _codeTxt.attributedPlaceholder = codeAttri;
    [_bgView addSubview:_codeTxt];
    
    UILabel *lineLbl4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 300, kScreenWidth - 30, 0.25)];
    lineLbl4.backgroundColor=LINEGREEN;
    [_bgView addSubview:lineLbl4];
    
    UILabel *lineLbl5 = [[UILabel alloc] initWithFrame:CGRectMake(15, 300, kScreenWidth - 30, 0.25)];
    lineLbl5.backgroundColor=LINEWHITE;
    [_bgView addSubview:lineLbl5];
//----------------------------------------------
    UIImageView *repeatImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeIcon"]];
    repeatImg.frame = CGRectMake(20, 315, 15, 20);
    [_bgView addSubview:repeatImg];
    
    NSString *repeatPlaceholde = @"重复输入密码";
    NSMutableAttributedString *repeatAttri = [[NSMutableAttributedString alloc] initWithString:repeatPlaceholde];
    [repeatAttri setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} range:NSMakeRange(0, repeatAttri.length)];
    
    _repeatTxt = [[UITextField alloc] initWithFrame:CGRectMake(45, 310, kScreenWidth - 80, 30)];
    _repeatTxt.textColor = [UIColor whiteColor];
    _repeatTxt.font = [UIFont systemFontOfSize:15.0f];
    _repeatTxt.secureTextEntry = YES;
    _repeatTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    _repeatTxt.delegate = self;
    _repeatTxt.attributedPlaceholder = repeatAttri;
    [_bgView addSubview:_repeatTxt];
    
    UILabel *lineLbl6 = [[UILabel alloc] initWithFrame:CGRectMake(15, 345, kScreenWidth - 30, 0.25)];
    lineLbl6.backgroundColor=LINEGREEN;
    [_bgView addSubview:lineLbl6];
    
    UILabel *lineLbl7 = [[UILabel alloc] initWithFrame:CGRectMake(15, 345.25, kScreenWidth - 30, 0.25)];
    lineLbl7.backgroundColor=LINEWHITE;
    [_bgView addSubview:lineLbl7];
//----------------------------------------------
    UIImageView *sugImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"suggestIcon"]];
    sugImg.frame = CGRectMake(20, 360, 15, 20);
    [_bgView addSubview:sugImg];
    
    NSString *sugPlaceholde = @"输入推荐人手机号";
    NSMutableAttributedString *sugAttri = [[NSMutableAttributedString alloc] initWithString:sugPlaceholde];
    [sugAttri setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} range:NSMakeRange(0, sugAttri.length)];
    _suggestTxt = [[UITextField alloc] initWithFrame:CGRectMake(45, 355, kScreenWidth - 80, 30)];
    _suggestTxt.textColor = [UIColor whiteColor];
    _suggestTxt.font = [UIFont systemFontOfSize:15.0f];
    _suggestTxt.keyboardType = UIKeyboardTypePhonePad;
    _suggestTxt.delegate = self;
    _suggestTxt.hidden = _IS_QRSCAN;
    _suggestTxt.attributedPlaceholder = sugAttri;
    [_bgView addSubview:_suggestTxt];
    
    UILabel *sepLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 390, kScreenWidth - 30, 0.25)];
    sepLbl.backgroundColor = LINEGREEN;
    sepLbl.hidden = _IS_QRSCAN;
    [_bgView addSubview:sepLbl];
    
    UILabel *sepLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 390.25, kScreenWidth - 30, 0.25)];
    sepLbl1.backgroundColor = LINEWHITE;
    sepLbl1.hidden = _IS_QRSCAN;
    [_bgView addSubview:sepLbl1];
//----------------------------------------------
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(15, 460, kScreenWidth - 30, 45);
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    confirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    confirmBtn.layer.cornerRadius = CGRectGetWidth(confirmBtn.frame) / 32;
    [confirmBtn setTitle:@"注册" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor whiteColor]];
    [confirmBtn addTarget:self action:@selector(submitReg) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:confirmBtn];
//------------------------------------------------
    _selecBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selecBtn.frame = CGRectMake(15, 420, 20, 20);
    [_selecBtn setBackgroundImage:[UIImage imageNamed:@"deal_select"] forState:UIControlStateSelected];
    [_selecBtn setBackgroundImage:[UIImage imageNamed:@"deal_unselect"] forState:UIControlStateNormal];
    [_selecBtn addTarget:self action:@selector(selectBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    _selecBtn.selected = NO;
    [_bgView addSubview:_selecBtn];
    
    UILabel *agreeLbl =  [[UILabel alloc] initWithFrame:CGRectMake(40, 420, 95, 20)];
    agreeLbl.font = [UIFont systemFontOfSize:13.0f];
    agreeLbl.textColor = [UIColor whiteColor];
    agreeLbl.text = @"我已阅读并接受";
    [_bgView addSubview:agreeLbl];
    
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame = CGRectMake(135, 420, 95, 20);
    agreeBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [agreeBtn setTitle:@"好园区用户协议" forState:UIControlStateNormal];
    [agreeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(showAgreementWeb) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:agreeBtn];
//------------------------------------------------
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
//------------------------------------------
    UIButton *acceptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    acceptBtn.frame = CGRectMake(15, 520, 100, 20);
    acceptBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    acceptBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    [acceptBtn setTitle:@"已有账号，点击登录" forState:UIControlStateNormal];
    [acceptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [acceptBtn addTarget:self action:@selector(dismissRegisterController) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:acceptBtn];
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

- (void)selectBtnPressed
{
    _selecBtn.selected = !_selecBtn.selected;
}

- (void)showAgreementWeb
{
    InfoWebViewController *webVC = [[InfoWebViewController alloc] initWithUrl:AGREEMENT_URL andTitle:@"好园区协议"];
    [self presentViewController:webVC animated:YES completion:^(void){}];
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

- (void)submitReg
{
    NSString *passwordValue = _codeTxt.text;
    NSString *phoneNumValue = _phoneTxt.text;
    NSString *verifyCodeValue = _resendTxt.text;
    NSString *sugPhoneValue = _suggestTxt.text;
    NSString *repeatCodeValue = _repeatTxt.text;
    
    if (passwordValue && passwordValue.length > 0 && phoneNumValue && phoneNumValue.length > 0 && verifyCodeValue && verifyCodeValue.length > 0 && repeatCodeValue.length > 0 && _selecBtn.isSelected)
    {
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
            
        }else if (![verCodePredicate evaluateWithObject:verifyCodeValue]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码有误"
                                                            message:@"验证码为四位数字"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            alert.tag = 204;
            [alert show];
            
            return;
            
        }else if (![passwordValue isEqualToString:repeatCodeValue]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码有误"
                                                            message:@"重复输入密码不符！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
            return;
        }else {
            
            [self resignFirstResponder];
            
            [self showNoTextStateHud];
            
            self.stateHud.labelText = @"正在提交..";
            
            [self registerOperation];
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
    }else if (!repeatCodeValue || repeatCodeValue.length == 0){
        [self showStateHudWithText:@"重复密码不能为空"];
        [_repeatTxt becomeFirstResponder];
    }else if (sugPhoneValue && sugPhoneValue.length > 0){
        //  手机号正则
        NSString *mobileRegex = @"[1][34578][0-9]{9}";
        NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
        if(![mobilePredicate evaluateWithObject:sugPhoneValue]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入正确的推荐人手机号码"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            alert.tag = 205;
            [alert show];
            
            return;
        }
    }else if (!_selecBtn.isSelected){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请勾选好园区用户协议表示赞同！"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
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
        } else {
            p++;
        }
    }
    return strlength;
}

#pragma mark - registerRequest
- (void)registerOperation
{
    _phone = _phoneTxt.text;
    _pswMD5   = _codeTxt.text.md5;
    _verCode  = _resendTxt.text;
    
    if (!_sugPhone) {
        _sugPhone = _suggestTxt.text;
    }

    HYQRegistResponse *response = [[HYQRegistResponse alloc] initWithPhone:_phone andWithCode:_pswMD5 andWithVerCode:_verCode andWithSPhone:_sugPhone];
    response.delegate = self;
    [response start];
}

#pragma mark - sendVerCodeOperation
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
    HYQSendVerCodeResponse *response = [[HYQSendVerCodeResponse alloc] initWithPhoneNumber:_phoneTxt.text];
    response.delegate = self;
    [response start];
}

- (void)updateReSendTime:(NSTimer *)timer
{
    _reSendTime -= 1;
    
    if (_reSendTime >= 0) {
        [_getResendBtn setTitle:[NSString stringWithFormat:@"%lds 重新获取", _reSendTime] forState:UIControlStateNormal];
    } else {
        _getResendBtn.alpha = 0.8;
        [_getResendBtn setBackgroundColor:GRAY_COLOR];
        [_getResendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getResendBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
        [_getResendBtn setBackgroundImage:[UIImage imageNamed:@"loginIcon"] forState:UIControlStateNormal];
        
        _getResendBtn.enabled = YES;
        _captchaTimer = nil;
    }
}

#pragma mark RegistResponse Delegate
- (void)registSucceed
{
    [self showStateHudWithText:@"注册成功！"];
    
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC);
    dispatch_after(dispatch_time(time, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^(void){}];
    });
}

#pragma mark - sendVerCode Delegate
- (void)sendVerCodeSucceed
{
    _getResendBtn.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    [_getResendBtn setTitle:@"120s 重新获取" forState:UIControlStateNormal];
    _getResendBtn.enabled = NO;
    _reSendTime = 120;
    
    _captchaTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                     target:self
                                                   selector:@selector(updateReSendTime:)
                                                   userInfo:nil
                                                    repeats:YES];
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self showStateHudWithText:text];
}

- (void)phoneAlreadyExist
{
    UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"账号已存在！请直接登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alertView.tag = 100;
    alertView.delegate = self;
    [alertView show];
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
        
    } else if (alertView.tag == 205){
        [_suggestTxt becomeFirstResponder];
    }
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        [self dismissRegisterController];
    }
}

@end