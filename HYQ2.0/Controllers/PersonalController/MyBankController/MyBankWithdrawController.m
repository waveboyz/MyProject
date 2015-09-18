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

@end

@implementation MyBankWithdrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    _tableview.tableHeaderView = header;
    [self.view addSubview:_tableview];
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
    switch (indexPath.row) {
        case 0:
        {
            _nameField = [[UITextField alloc] initWithFrame:CGRectMake(70, 0, kScreenWidth - 70, 44)];
            _nameField.font = [UIFont systemFontOfSize:15.0f];
            _nameField.textColor = [UIColor blackColor];
            _nameField.placeholder = _placeArr[indexPath.row];
            [cell.contentView addSubview:_nameField];
        }
            break;
        case 1:
        {
            _cardField = [[UITextField alloc] initWithFrame:CGRectMake(70, 0, kScreenWidth - 70, 44)];
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
            _cashField.placeholder = [NSString stringWithFormat:@"%@%@",_placeArr[indexPath.row],[account stringValue]];
            [cell.contentView addSubview:_cashField];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

@end