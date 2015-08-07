//
//  MyAddressController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyAddressController.h"

@interface MyAddressController ()

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation MyAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址管理";
    self.view.backgroundColor = GRAY_COLOR;
    [self createUI];
}

- (void)createUI
{
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]];
    addBtn.frame = CGRectMake(0, kScreenHeight - 60, kScreenWidth, 60);
    [addBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addNewAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 124) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = ORANGE_COLOR;
    
    [self.view addSubview:_tableview];
}

- (void)addNewAddress
{
    
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ADDRESS_CELL = @"address_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADDRESS_CELL];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ADDRESS_CELL];
    }
    
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}
@end
