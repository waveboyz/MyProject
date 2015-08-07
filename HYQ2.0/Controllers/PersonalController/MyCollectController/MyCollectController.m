//
//  MyCollectController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyCollectController.h"

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
    _tableview.backgroundColor = ORANGE_COLOR;
    
    [self.view addSubview:_tableview];
}

- (void)editBtnPressed
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
    static NSString *COLLECT_CELL = @"collect_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COLLECT_CELL];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:COLLECT_CELL];
    }
    
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}

@end
