//
//  ExcellentFinantialController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/10.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentFinantialController.h"
#import "ExcellentFinantialFirstCell.h"
#import "ExcellentFinantialSecondCell.h"
#import "ExcellentFinantialThirdCell.h"
#import "ExcellentFinantialForthCell.h"
#import "UploadPlanController.h"

@interface ExcellentFinantialController ()

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation ExcellentFinantialController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优创金融计划";
    
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
    [joinBtn addTarget:self action:@selector(joinBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:joinBtn];
}

- (void)joinBtnPressed
{
    UploadPlanController *uploadVC = [[UploadPlanController alloc] init];
    [self.navigationController pushViewController:uploadVC animated:YES];
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
    static NSString *FINAN_FIRST_CELL   = @"finantial_first_cell";
    static NSString *FINAN_SECOND_CELL  = @"finantial_second_cell";
    static NSString *FINAN_THIRD_CELL   = @"finantial_third_cell";
    static NSString *FINAN_FORTH_CELL   = @"finantial_forth_cell";
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:FINAN_FIRST_CELL];
        if (!cell) {
            cell = [[ExcellentFinantialFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FINAN_FIRST_CELL];
        }
    }else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:FINAN_SECOND_CELL];
        if (!cell) {
            cell = [[ExcellentFinantialSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FINAN_SECOND_CELL];
        }
    }else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:FINAN_THIRD_CELL];
        if (!cell) {
            cell = [[ExcellentFinantialThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FINAN_THIRD_CELL];
        }
    }else if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:FINAN_FORTH_CELL];
        if (!cell) {
            cell = [[ExcellentFinantialForthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FINAN_FORTH_CELL];
        }
    }

    return cell;
}

#pragma mark
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 180.0f;
    }else if (indexPath.section == 1) {
        return 240.0f;
    }else if (indexPath.section == 2){
        return 770.0f;
    }
    
    return 645.0f;
}

@end