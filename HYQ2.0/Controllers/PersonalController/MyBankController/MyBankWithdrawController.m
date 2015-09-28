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

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *cardField;
@property (nonatomic, strong) UITextField *cashField;
@property (nonatomic, assign) NSArray     *titleArr;
@property (nonatomic, assign) NSArray     *placeArr;
@property (nonatomic, strong) UIButton    *confirmBtn;

@end

@implementation MyBankWithdrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300) style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    _tableview.tableHeaderView = header;
    [self.view addSubview:_tableview];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(kScreenWidth * 0.5 - 70, 165, 140, 30);
    _confirmBtn.layer.cornerRadius = CGRectGetWidth(_confirmBtn.frame)/8;
    [_confirmBtn addTarget:self action:@selector(confirmBtnPressed) forControlEvents:UIControlEventTouchDragInside];
    [_confirmBtn setBackgroundColor:NAVIBAR_GREEN_COLOR];
    [_confirmBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_confirmBtn];
}

- (NSArray *)titleArr
{
    if (_titleArr) {
        _titleArr = @[@"账户提现",@"银行卡号",@"提现金额"];
    }
    
    return _titleArr;
}

- (NSArray *)placeArr
{
    if (_placeArr) {
        _placeArr = @[@"用户名（实名认证姓名）",@"输入您本人的银行卡号",@"本次最多可提现"];
    }
    
    return _placeArr;
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

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *BANK_CELL = @"bank_cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:BANK_CELL];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BANK_CELL];
    }
    cell.textLabel.text = _titleArr[indexPath.row];
    UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, kScreenWidth - 15, 0.5)];
    [cell.contentView addSubview:lineLbl];
    switch (indexPath.row) {
        case 0:
        {
            _nameField = [[UITextField alloc] initWithFrame:CGRectMake(70, 0, kScreenWidth - 70, 50)];
            _nameField.font = [UIFont systemFontOfSize:15.0f];
            _nameField.textColor = [UIColor blackColor];
            _nameField.placeholder = _placeArr[indexPath.row];
            [cell.contentView addSubview:_nameField];
        }
            break;
        case 1:
        {
            _cardField = [[UITextField alloc] initWithFrame:CGRectMake(70, 0, kScreenWidth - 70, 50)];
            _cardField.font = [UIFont systemFontOfSize:15.0f];
            _cardField.textColor = [UIColor blackColor];
            _cardField.placeholder = _placeArr[indexPath.row];
            [cell.contentView addSubview:_cardField];
        }
            break;
            
        case 2:
        {
            _cashField = [[UITextField alloc] initWithFrame:CGRectMake(70, 0, kScreenWidth - 70, 44)];
            _cashField.font = [UIFont systemFontOfSize:15.0f];
            _cashField.textColor = [UIColor blackColor];
            NSDictionary *userinfo = [[HYQUserManager sharedUserManager] userInfo];
            NSNumber *account = [userinfo objectForKey:@"account"];
            _cashField.placeholder = [NSString stringWithFormat:@"%@%@元",_placeArr[indexPath.row],[account stringValue]];
            [cell.contentView addSubview:_cashField];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.5f;
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