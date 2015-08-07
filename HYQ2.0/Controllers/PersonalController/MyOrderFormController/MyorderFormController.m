//
//  MyorderFormController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyorderFormController.h"
#import "VOSegmentedControl.h"

@interface MyorderFormController ()

@property (nonatomic,strong) VOSegmentedControl *segment;

@end

@implementation MyorderFormController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    [self createUI];
}

- (void)createUI
{
    _segment = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText:@"全部"},
                                                              @{VOSegmentText:@"待付款"},
                                                              @{VOSegmentText:@"待服务"},
                                                              @{VOSegmentText:@"待评价"}]];
    _segment.frame = CGRectMake(0, 64, kScreenWidth, 40);
    _segment.contentStyle = VOContentStyleTextAlone;
    _segment.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    _segment.backgroundColor = BG_GRAY_COLOR;
    _segment.selectedBackgroundColor = _segment.backgroundColor;
    _segment.allowNoSelection = NO;
    _segment.indicatorThickness = 4;
    _segment.selectedTextColor = NAVIBAR_GREEN_COLOR;
    _segment.selectedIndicatorColor = NAVIBAR_GREEN_COLOR;
    [self.view addSubview:_segment];
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
    static NSString *ORDER_CELL = @"order_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ORDER_CELL];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ORDER_CELL];
        cell.backgroundColor = ORANGE_COLOR;
    }
    
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
