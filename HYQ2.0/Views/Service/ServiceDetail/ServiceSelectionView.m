//
//  ServiceSelectionView.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/19.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceSelectionView.h"
#import "GlobalConst.h"

@implementation ServiceSelectionView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 170) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor grayColor];
    [self addSubview:_tableView];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(15, kScreenWidth - 50, kScreenWidth - 30, 30);
    [confirmBtn setBackgroundColor:[UIColor whiteColor]];
    [confirmBtn setTitle:@"确认选择" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
}

- (void)confirmBtnPressed
{

}

#pragma mark UITableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    return cell;
}

@end