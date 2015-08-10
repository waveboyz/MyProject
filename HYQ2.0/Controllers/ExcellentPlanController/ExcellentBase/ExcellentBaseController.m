//
//  ExcellentBaseController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/10.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentBaseController.h"
#import "ExcellentBaseFirstCell.h"

@interface ExcellentBaseController ()

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation ExcellentBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优创基地";
    
    [self createUI];
}

- (void)createUI
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.backgroundColor = nil;
    _tableview.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableview];
    
    UIButton *joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    joinBtn.frame = CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49);
    joinBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    joinBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    joinBtn.alpha = 0.8;
    [joinBtn setTitle:@"申请加入" forState:UIControlStateNormal];
    [joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [joinBtn setBackgroundColor:NAVIBAR_GREEN_COLOR];
    [joinBtn addTarget:self action:@selector(tableviewScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:joinBtn];
}

- (void)tableviewScrollToTop
{
    [_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

#pragma mark UITableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *BASE_FIRST_CELL = @"base_first_cell";
    static NSString *BASE_CELL = @"base_cell";
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:BASE_FIRST_CELL];
        if (!cell) {
            cell = [[ExcellentBaseFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BASE_FIRST_CELL];
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:BASE_CELL];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BASE_CELL];
        }
    }

    return cell;
}

#pragma mark
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    footer.backgroundColor = BG_GRAY_COLOR;
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    
    return 30;
}

@end