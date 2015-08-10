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
#import "ExcellentThirdCell.h"
#import "ExcellentForthCell.h"
#import "ExcellentBaseController.h"
#import "ExcellentCampController.h"
#import "ExcellentFinantialController.h"
#import "ExcellentOpenDayController.h"

@interface ExcellentPlanController ()
<
    ExcellentHeaderCellDelegate
>

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
    _tableview.showsVerticalScrollIndicator = NO;
    
    UIButton *joinBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - 89, kScreenWidth, 40)];
    joinBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    joinBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    joinBtn.alpha = 0.8;
    [joinBtn setTitle:@"申请加入" forState:UIControlStateNormal];
    [joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [joinBtn setBackgroundColor:NAVIBAR_GREEN_COLOR];
    [joinBtn addTarget:self action:@selector(tableviewScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:joinBtn];
    [self.view addSubview:_tableview];
}

- (void)tableviewScrollToTop
{
    [_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
    static NSString *THIRD_CELL  = @"third_cell";
    static NSString *FORTH_CELL  = @"forth_cell";

    UITableViewCell *cell;
    if (indexPath.section == 0) {
      cell = [tableView dequeueReusableCellWithIdentifier:HEADER_CELL];
        if (!cell) {
            cell = [[ExcellentHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HEADER_CELL];
            [(ExcellentHeaderCell *)cell setDelegate:self];
        }
    }else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:SECOND_CELL];
        if (!cell) {
            cell = [[ExcellentSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SECOND_CELL];
        }
    }else if(indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:THIRD_CELL];
        if (!cell) {
            cell = [[ExcellentThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:THIRD_CELL];
        }
    }else if(indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:FORTH_CELL];
        if (!cell) {
            cell = [[ExcellentForthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FORTH_CELL];
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
        CGFloat IconWidth = (kScreenWidth - 160) / 4;
        
        return 190 + IconWidth;
    }else if(indexPath.section == 1){
        if (IS_IHPONE4||IS_IPHONE5) {
            return 305;
        }
        
        return 285;
    }else if (indexPath.section == 2){
        return 145;
    }
        return 260;
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

#pragma mark ExcellentHeaderCellDelegate
- (void)iconTouchedWithTag:(NSInteger)tag
{
    switch (tag) {
        case 0:{
            ExcellentFinantialController *finanVC = [[ExcellentFinantialController alloc] init];
            [self.navigationController pushViewController:finanVC animated:YES];
        }
            break;
            
        case 1:{
            ExcellentBaseController *baseVC = [[ExcellentBaseController alloc] init];
            [self.navigationController pushViewController:baseVC animated:YES];
        }
            break;
            
        case 2:{
            ExcellentCampController *campVC = [[ExcellentCampController alloc] init];
            [self.navigationController pushViewController:campVC animated:YES];
        }
            break;
            
        case 3:{
            ExcellentOpenDayController *openVC = [[ExcellentOpenDayController alloc] init];
            [self.navigationController pushViewController:openVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end