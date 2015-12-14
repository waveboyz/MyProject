//
//  MyAddressPickController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/2.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyAddressPickController.h"
#import "MJExtension.h"

@interface MyAddressPickController ()

@property (nonatomic, retain) NSMutableArray *addressArr;           //区数组
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyAddressPickController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择地址";
    [self createUI];
}

- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = BG_GRAY_COLOR;
    [self.view addSubview:_tableView];
}

- (NSArray *)addressArr
{
    if (_addressArr == nil) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Address.plist" ofType:nil]];
        NSArray *dictArray = [dic objectForKey:@"Address"];
        _addressArr = [DistrictModel objectArrayWithKeyValuesArray:dictArray];
    }
    
    return _addressArr;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DISTRICT_CELL = @"district_cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:DISTRICT_CELL];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DISTRICT_CELL];
    }
    DistrictModel *district = self.addressArr[indexPath.row];
    cell.textLabel.text = district.location;
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DistrictModel *district = _addressArr[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(finishPickAddressWith:)]) {
        [self.delegate finishPickAddressWith:district];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedAddPick" object:district];
    [self.navigationController popViewControllerAnimated:YES];
}

@end