//
//  MyCollectController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyCollectController.h"
#import "MyCollectCell.h"

@interface MyCollectController ()

@property (nonatomic,strong) UITableView *tableview;

@end

@implementation MyCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self createUI];
}

- (void)createUI
{
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editBtnPressed)];
    [self.navigationItem setRightBarButtonItem:editItem];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableview.delegate =self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = GRAY_COLOR;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableview];
}

- (void)editBtnPressed
{
    [_tableview setEditing:YES animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *COLLECT_CELL = @"collect_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COLLECT_CELL];
    if (!cell) {
        cell = [[MyCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:COLLECT_CELL];
    }
    
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.5f;
}

@end