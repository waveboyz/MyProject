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
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = BG_GRAY_COLOR;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
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

@end