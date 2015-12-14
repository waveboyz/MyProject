//
//  ServiceAddressPickController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/9.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceAddressPickController.h"
#import "MyAddressCell.h"
#import "AddressModel.h"
#import "MyAddressAddController.h"
#import "MyAddressResponse.h"

@interface ServiceAddressPickController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    MyAddressAddControllerDelegate,
    MyAddressResponseDelegate
>

@property (nonatomic, retain)   NSMutableArray      *dataArr;
@property (nonatomic, strong)   UITableView         *tableview;
@property (nonatomic, strong)   UIButton            *addBtn;

@end

@implementation ServiceAddressPickController

- (id)init
{
    if (self = [super init]) {
        _dataArr = [NSMutableArray new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAddressOperation];
    [self createUI];
}

- (void)getAddressOperation
{
    [self showNoTextStateHud];
    MyAddressResponse *response = [[MyAddressResponse alloc] init];
    response.delegate = self;
    [response start];
}

- (void)createUI
{
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]];
    _addBtn.frame = CGRectMake(0, kScreenHeight - 60, kScreenWidth, 60);
    [_addBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addNewAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 124) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = BG_GRAY_COLOR;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
}

- (void)addNewAddress
{
    MyAddressAddController *addVC = [[MyAddressAddController alloc] init];
    addVC.delegate = self;
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ADDRESS_CELL = @"address_cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:ADDRESS_CELL];
    
    if (!cell) {
        cell = [[MyAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ADDRESS_CELL];
    }
    [(MyAddressCell *)cell setAddress:_dataArr[indexPath.row]];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(finishPickWithAddress:)]) {
        [self.delegate finishPickWithAddress:_dataArr[indexPath.row]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.5f;
}

#pragma mark MyAddressAddControllerDelegate
- (void)addAddressSucceed
{
    [self.dataArr removeAllObjects];
    [self getAddressOperation];
}

#pragma mark MyAddressResponseDelegate
- (void)getAddressArrayWith:(NSMutableArray *)array
{
    [self stopStateHud];
    _dataArr = array;
    [self.tableview reloadData];
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self showStateHudWithText:text];
}

- (void)noDataArr
{
    [self stopStateHud];
    [self showStateHudWithText:@"暂无地址~"];
}
@end