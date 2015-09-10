//
//  HYQReplaceNickController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/8.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQReplaceNickController.h"
#import "HYQUserManager.h"
#import "HYQReplaceUsername.h"

@interface HYQReplaceNickController ()
<
    HYQReplaceUsernameDelegate
>

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UIButton    *commitBtn;

@end

@implementation HYQReplaceNickController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    [self createUI];
}

- (void)createUI
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 94, kScreenWidth, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    _nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 20, 50)];
    _nameField.font = [UIFont systemFontOfSize:15.0f];
    [backView addSubview:_nameField];
    NSDictionary *userInfo  =  [[HYQUserManager sharedUserManager] userInfo];
    _nameField.text = [userInfo objectForKey:@"username"];
    _nameField.textColor = [UIColor grayColor];
    _nameField.delegate = self;
    
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
    if ([_nameField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"昵称不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [self replaceNickNameOperation];
    }
}

- (void)replaceNickNameOperation
{
    [self showNoTextStateHud];
    HYQReplaceUsername *response = [[HYQReplaceUsername alloc] initWithNickName:_nameField.text];
    response.delegate = self;
    [response start];
}

#pragma mark HYQReplaceUsernameDelegate
- (void)replaceUsernameSucceed
{
    [self stopStateHud];
    [self showStateHudWithText:@"修改成功！"];
    [self updateUserInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"replaceNickName" object:nil];
    [self performSelector:@selector(dismissSelf) withObject:nil afterDelay:1.5];
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self showStateHudWithText:text];
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _nameField.textColor = [UIColor blackColor];
}

//-------------------------------------
- (void)updateUserInfo
{
    NSDictionary *userInfo  =  [[HYQUserManager sharedUserManager] userInfo];
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [newDic removeObjectForKey:@"username"];
    [newDic setObject:_nameField.text forKey:@"username"];
    [[HYQUserManager sharedUserManager] updateUserInfo:newDic];
}

- (void)dismissSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end