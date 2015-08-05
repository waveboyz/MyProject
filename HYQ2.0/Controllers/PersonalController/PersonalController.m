//
//  PersonalController.m
//  HYQ
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "PersonalController.h"
#import "BasePersonHeadCell.h"
#import "HYQLoginController.h"
#import "MyPaymentController.h"
#import "MYDiscountController.h"
#import "MyorderFormController.h"
#import "MyCollectController.h"
#import "MyAddressController.h"
#import "EditPersonFileControllerViewController.h"

@interface PersonalController ()

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray     *titleArr;
@property (nonatomic, retain) NSArray     *title2Arr;

@end

@implementation PersonalController

- (id)init
{
    if (self = [super init]) {
        _titleArr = @[@"我的提成",@"我的优惠券"];
        _title2Arr = @[@"我的订单",@"我的收藏夹",@"地址管理"];
    }
    
    return self;
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = BG_GRAY_COLOR;
    self.title = @"个人中心";
    [self createUI];
}

- (void)createUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = BG_GRAY_COLOR;

    [self.view addSubview:self.tableView];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }else if (section == 2)
    {
        return 3;
    }else if (section ==3){
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PERSON_CELL = @"personal_cell";
    static NSString *NORMAL_CELL = @"normal_cell";
    static NSString *THIRD_CELL = @"third_cell";
    static NSString *FOURTH_CELL = @"fourth_cell";
    
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:PERSON_CELL];
        
        if (!cell) {
            cell = [[BasePersonHeadCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:PERSON_CELL];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:NORMAL_CELL];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NORMAL_CELL];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

        cell.textLabel.text = _titleArr[indexPath.row];
        UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, kScreenWidth - 15, 0.5)];
        if (IS_IHPONE4) {
            lineLbl.frame = CGRectMake(15, 30, kScreenWidth - 15, 0.5);
        }
        lineLbl.backgroundColor = LINE_COLOR;
        [cell.contentView addSubview:lineLbl];
    }
    
    if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:THIRD_CELL];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:THIRD_CELL];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

        cell.textLabel.text = _title2Arr[indexPath.row];
        UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, kScreenWidth - 15, 0.5)];
        if (IS_IHPONE4) {
            lineLbl.frame = CGRectMake(15, 30, kScreenWidth - 15, 0.5);
        }
        lineLbl.backgroundColor = LINE_COLOR;
        [cell.contentView addSubview:lineLbl];
    }
    
    if (indexPath.section == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:FOURTH_CELL];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FOURTH_CELL];
        }
        UILabel *logoutLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 -60, 15, 120, 20)];
        logoutLbl.font = [UIFont systemFontOfSize:15.0f];
        logoutLbl.text = @"安全退出账号";
        logoutLbl.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:logoutLbl];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80.5;
    }
    if (indexPath.section > 0) {
        if (IS_IHPONE4) {
            return 30.5;
        }
        return 50.5;
    }
    
    return 0;
}

#pragma mark UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section >= 0) {
        return 20;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        EditPersonFileControllerViewController *editVC = [[EditPersonFileControllerViewController alloc] init];
        [self.navigationController pushViewController:editVC animated:YES];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MyPaymentController *paymentVC = [[MyPaymentController alloc] init];
            [self.navigationController pushViewController:paymentVC animated:YES];
        }
        if (indexPath.row == 1) {
            MYDiscountController *discountVC = [[MYDiscountController alloc] init];
            [self.navigationController pushViewController:discountVC animated:YES];
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            MyorderFormController *orderVC = [[MyorderFormController alloc] init];
            [self.navigationController pushViewController:orderVC animated:YES];
        }
        if (indexPath.row == 1) {
            MyCollectController *collectVC = [[MyCollectController alloc] init];
            [self.navigationController pushViewController:collectVC animated:YES];
        }
        if (indexPath.row == 2) {
            MyAddressController *addVC = [[MyAddressController alloc] init];
            [self.navigationController pushViewController:addVC animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section >= 0) {
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        bgview.backgroundColor = BG_GRAY_COLOR;
        
        return bgview;
    }

    return nil;
}

@end
