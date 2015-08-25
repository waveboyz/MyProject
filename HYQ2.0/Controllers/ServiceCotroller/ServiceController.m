//
//  FirstViewController.m
//  TestProject
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanTec. All rights reserved.
//

#import "ServiceController.h"
#import "VOSegmentedControl.h"
#import "ServiceViewCell.h"
#import "ServiceDetailController.h"
#import "ServiceModel.h"

@interface ServiceController ()

@property (nonatomic, strong) VOSegmentedControl *segment;

@end

@implementation ServiceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"产品服务";
    [self createUI];
}

- (void)createUI
{
    _segment = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"财务服务"},
                                                              @{VOSegmentText: @"法律服务"},
                                                              @{VOSegmentText: @"信息化服务"},
                                                              @{VOSegmentText: @"金融服务"},
                                                              @{VOSegmentText: @"培训服务"}]];
    _segment.frame = CGRectMake(0, 64, kScreenWidth, 40);
    _segment.contentStyle = VOContentStyleTextAlone;
    _segment.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    _segment.backgroundColor = BG_GRAY_COLOR;
    _segment.selectedBackgroundColor = _segment.backgroundColor;
    _segment.allowNoSelection = NO;
    _segment.indicatorThickness = 3;
    _segment.selectedTextColor = NAVIBAR_GREEN_COLOR;
    _segment.selectedIndicatorColor = NAVIBAR_GREEN_COLOR;
    [self.view addSubview:_segment];
    [_segment addTarget:self action:@selector(swipSegmentWithIndexPath:) forControlEvents:UIControlEventValueChanged];
}

- (void)swipSegmentWithIndexPath:(NSUInteger)indexpath
{
    [self.tableView.header beginRefreshing];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SERVICE_CELL = @"service_cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:SERVICE_CELL];
    
    if (!cell) {
        cell = [[ServiceViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SERVICE_CELL];
    }

    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceDetailController *detail = [[ServiceDetailController alloc] init];
    [self presentViewController:detail animated:YES completion:^(void){}];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.5f;
}

@end