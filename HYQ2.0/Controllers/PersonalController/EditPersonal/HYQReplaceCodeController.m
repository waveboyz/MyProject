//
//  HYQReplaceCodeController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/8.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQReplaceCodeController.h"
#import "HYQUserManager.h"
#import "ReplaceCodeResponse.h"
#import "NSString+HCBStringHelper.h"

@interface HYQReplaceCodeController ()
<
    ReplaceCodeResponseDelegate
>

@property (nonatomic, strong) UITextField *codeField;
@property (nonatomic, strong) UIButton    *commitBtn;

@end

@implementation HYQReplaceCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self createUI];
}

- (void)createUI
{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 94, kScreenWidth, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    _codeField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 20, 50)];
    _codeField.font = [UIFont systemFontOfSize:15.0f];
    _codeField.textColor = [UIColor blackColor];
    _codeField.secureTextEntry = YES;
    _codeField.placeholder = @"请输入新密码";
    _codeField.returnKeyType = UIReturnKeyGo;
    _codeField.delegate = self;
    [backView addSubview:_codeField];

    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.frame = CGRectMake(30, 164, kScreenWidth - 40, 40);
    _commitBtn.layer.cornerRadius = CGRectGetWidth(_commitBtn.frame)/16;
    [_commitBtn setBackgroundColor:NAVIBAR_GREEN_COLOR];
    [_commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    _commitBtn.titleLabel.textColor = [UIColor whiteColor];
    [_commitBtn addTarget:self action:@selector(commitBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commitBtn];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapGes];
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void)commitBtnPressed
{
    if ([_codeField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        NSString *passwordValue = _codeField.text;
        NSString *pwdRegex = @"^.{6,20}$";
        NSPredicate *pwdPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdRegex];
        
        if (![pwdPredicate evaluateWithObject:passwordValue]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码不合法"
                                                            message:@"密码长度需在6-20个字符之间"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }else{
        [self replaceCodeOperation];
        }
    }
}

- (void)replaceCodeOperation
{
    [self showNoTextStateHud];
    ReplaceCodeResponse *response = [[ReplaceCodeResponse alloc] initWithCode:_codeField.text.md5];
    response.delegate = self;
    [response start];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self commitBtnPressed];
    return YES;
}

#pragma mark ReplaceCodeResponseDelegate
- (void)replaceCodeSucceed
{
    [self stopStateHud];
    [self showStateHudWithText:@"修改成功！"];
    [self updateUserInfo];
    [self performSelector:@selector(dismissSelf) withObject:nil afterDelay:1.5];
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self showStateHudWithText:text];
}

//-------------------------------------
- (void)updateUserInfo
{
    NSDictionary *userInfo  =  [[HYQUserManager sharedUserManager] userInfo];
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [newDic removeObjectForKey:@"psw"];
    [newDic setObject:_codeField.text.md5 forKey:@"psw"];
    [[HYQUserManager sharedUserManager] updateUserInfo:newDic];
}

- (void)dismissSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end