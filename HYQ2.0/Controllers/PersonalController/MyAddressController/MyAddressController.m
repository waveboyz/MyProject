//
//  MyAddressController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyAddressController.h"
#import "MyAddressAddController.h"
#import "MyAddressCell.h"
#import "MyAddressResponse.h"

@interface MyAddressController ()
<
    MyAddressResponseDelegate
>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIButton      *addBtn;
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, assign) NSUInteger    currentPage;

@end

@implementation MyAddressController

- (id)init
{
    if (self = [super init]) {
        _dataArr = [NSMutableArray new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址管理";
    self.view.backgroundColor = GRAY_COLOR;
    [self createUI];
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
    _tableview.backgroundColor = GRAY_COLOR;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.showsVerticalScrollIndicator = NO;
    
//    UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(showEditController)];
//    self.navigationItem.rightBarButtonItem = editBtn;
    
    [self.view addSubview:_tableview];
    [self getAddressOperation];
}

//获取地址列表请求
- (void)getAddressOperation
{
    [self showNoTextStateHud];
    MyAddressResponse *response = [[MyAddressResponse alloc] init];
    response.delegate = self;
    [response start];
}

//添加新地址
- (void)addNewAddress
{
    MyAddressAddController *addVC = [[MyAddressAddController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}

//编辑地址
- (void)showEditController
{
    self.tableview.allowsMultipleSelectionDuringEditing = YES;
    [self.tableview setEditing:YES animated:YES];
}

#pragma mark MyAddressResponseDelegate
- (void)getAddressArrayWith:(NSMutableArray *)array
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        self.dataArr = array;
        [self.tableview reloadData];
    });
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self showStateHudWithText:text];
}

- (void)noDataArr
{
    [self stopStateHud];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ADDRESS_CELL = @"address_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ADDRESS_CELL];
    if (!cell) {
        cell = [[MyAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ADDRESS_CELL];
    }
    [(MyAddressCell *)cell setAddress:self.dataArr[indexPath.row]];

    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.5f;
}

@end