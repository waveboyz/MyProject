//
//  ExcellentCampController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/10.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentCampController.h"
#import "ExcellentCampFirstCell.h"
#import "ExcellentCampSecondCell.h"
#import "ExcellentCampThirdCell.h"
#import "ExcellentCampForthCell.h"
#import "UploadPlanController.h"

@interface ExcellentCampController ()

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation ExcellentCampController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优创训练营";
    
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
    static NSString *CAMP_FIRST_CELL = @"camp_first_cell";
    static NSString *CAMP_SECOND_CELL = @"camp_second_cell";
    static NSString *CAMP_THIRD_CELL = @"camp_third_cell";
    static NSString *CAMP_FORTH_CELL = @"camp_forth_cell";
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:CAMP_FIRST_CELL];
        if (!cell) {
            cell = [[ExcellentCampFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CAMP_FIRST_CELL];
        }
    }else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:CAMP_SECOND_CELL];
        if (!cell) {
            cell = [[ExcellentCampSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CAMP_SECOND_CELL];
        }
    }else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:CAMP_THIRD_CELL];
        if (!cell) {
            cell = [[ExcellentCampThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CAMP_THIRD_CELL];
        }
    }else if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:CAMP_FORTH_CELL];
        if (!cell) {
            cell = [[ExcellentCampForthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CAMP_FORTH_CELL];
        }
    }
    
    return cell;
}

#pragma mark
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 770.0f;
    }else if (indexPath.section == 3){
        return 275.0f;
    }
    
    return 180.0;
}

@end