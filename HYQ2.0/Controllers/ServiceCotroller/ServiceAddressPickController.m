//
//  ServiceAddressPickController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/9.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceAddressPickController.h"
#import "AddressModel.h"

@interface ServiceAddressPickController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, retain)   NSMutableArray *dataArr;
@property (nonatomic, strong)   UITableView     *tableview;

@end

@implementation ServiceAddressPickController

- (id)initWithAddressArray:(NSArray *)addressArr
{
    if (self = [super init]) {
        _dataArr = [NSMutableArray arrayWithArray:addressArr];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    [self.tableview addSubview:_tableview];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ADDRESS_CELL];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    ServiceAddressPickController *addVC = [[ServiceAddressPickController alloc] initWithAddressArray:_dataArr];
    [self.navigationController pushViewController:addVC animated:YES];
}

@end