//
//  MyBankWithdrawController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/16.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyBankWithdrawController.h"
#import "HYQUserManager.h"

@interface MyBankWithdrawController ()

@property (nonatomic, strong) UIView      *bgView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *cardField;
@property (nonatomic, strong) UITextField *cashField;
@property (nonatomic, strong) UIButton    *confirmBtn;

@end

@implementation MyBankWithdrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 94, kScreenWidth, 151)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    //-----------------------------------------------
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 50)];
    lbl1.font = [UIFont systemFontOfSize:15.0f];
    lbl1.textColor = [UIColor blackColor];
    lbl1.text = @"账户提现";
    [_bgView addSubview:lbl1];
    
    _nameField = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, kScreenWidth -  150, 50)];
    _nameField.font = [UIFont systemFontOfSize:15.0f];
    _nameField.textColor = [UIColor blackColor];
    _nameField.placeholder = @"用户名（实名认证姓名）";
    [_bgView addSubview:_nameField];
    
    UILabel *lineLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, kScreenWidth - 30, 0.5)];
    lineLbl1.backgroundColor = LINE_COLOR;
    [_bgView addSubview:lineLbl1];
    //-----------------------------------------------
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50.5, 100, 50)];
    lbl2.font = [UIFont systemFontOfSize:15.0f];
    lbl2.textColor = [UIColor blackColor];
    lbl2.text = @"银行卡号";
    [_bgView addSubview:lbl2];
    
    _cardField = [[UITextField alloc] initWithFrame:CGRectMake(130, 50.5, kScreenWidth -  150, 50)];
    _cardField.font = [UIFont systemFontOfSize:15.0f];
    _cardField.textColor = [UIColor blackColor];
    _cardField.placeholder = @"输入您本人的银行卡号";
    [_bgView addSubview:_cardField];
    
    UILabel *lineLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 100.5, kScreenWidth - 30, 0.5)];
    lineLbl2.backgroundColor = LINE_COLOR;
    [_bgView addSubview:lineLbl2];
    //-----------------------------------------------
    UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 101, 100, 50)];
    lbl3.font = [UIFont systemFontOfSize:15.0f];
    lbl3.textColor = [UIColor blackColor];
    lbl3.text = @"提现金额";
    [_bgView addSubview:lbl3];
    
    NSDictionary *userDic = [[HYQUserManager sharedUserManager] userInfo];
    _cardField = [[UITextField alloc] initWithFrame:CGRectMake(130, 101, kScreenWidth -  150, 50)];
    _cardField.font = [UIFont systemFontOfSize:15.0f];
    _cardField.textColor = [UIColor blackColor];
    _cardField.placeholder = [NSString stringWithFormat:@"本次最多可提现%@元",[userDic objectForKey:@"property"]];
    [_bgView addSubview:_cardField];
    //---------------------------------------------
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(20, 260, kScreenWidth - 40, 50);
    [_confirmBtn addTarget:self action:@selector(confirmBtnPressed) forControlEvents:UIControlEventTouchDragInside];
    [_confirmBtn setBackgroundColor:NAVIBAR_GREEN_COLOR];
    [_confirmBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirmBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
}


- (void)confirmBtnPressed
{
    if ([_nameField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 200;
        [alert show];
    }else if ([_cardField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"银行卡不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 205;
        [alert show];
    }else if ([_cashField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"金额不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 210;
        [alert show];
    }
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonInde
{
    if (alertView.tag == 200) {
        [_nameField becomeFirstResponder];
    }else if (alertView.tag == 205){
        [_cardField becomeFirstResponder];
    }else if (alertView.tag == 210){
        [_cashField becomeFirstResponder];
    }
}

@end