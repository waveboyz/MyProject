//
//  ExcellentPlanController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentPlanController.h"
#import "ExcellentHeaderCell.h"
#import "ExcellentSecondCell.h"

@interface ExcellentPlanController ()

@property (nonatomic,strong) UITableView *tableview;

@end

@implementation ExcellentPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优创计划";
    
    [self createUI];
}

- (void)createUI
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 153) style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.backgroundColor = nil;
    
    UIButton *joinBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - 89, kScreenWidth, 40)];
    joinBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    joinBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    joinBtn.alpha = 0.8;
    [joinBtn setTitle:@"申请加入" forState:UIControlStateNormal];
    [joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [joinBtn setBackgroundColor:NAVIBAR_GREEN_COLOR];
//    [joinBtn addTarget:self action:@selector(startToLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:joinBtn];
    [self.view addSubview:_tableview];
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
    static NSString *HEADER_CELL = @"header_cell";
    static NSString *SECOND_CELL = @"second_cell";
    static NSString *EXCELLENT_CELL = @"excellent_cell";

    UITableViewCell *cell;
    if (indexPath.section == 0) {
      cell = [tableView dequeueReusableCellWithIdentifier:HEADER_CELL];
        if (!cell) {
            cell = [[ExcellentHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HEADER_CELL];
        }
    }else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:SECOND_CELL];
        if (!cell) {
            cell = [[ExcellentSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SECOND_CELL];
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:EXCELLENT_CELL];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EXCELLENT_CELL];
        }
    
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
    if (indexPath.section == 0) {
        return 220;
    }else if(indexPath.section == 1){
        return 146;
    }
        return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return nil;
    }
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    footer.backgroundColor = BG_GRAY_COLOR;
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 0;
    }
    
    return 30;
}

@end