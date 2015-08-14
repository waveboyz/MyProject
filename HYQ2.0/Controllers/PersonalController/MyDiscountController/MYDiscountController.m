//
//  MYDiscountController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MYDiscountController.h"
#import "VOSegmentedControl.h"
#import "MyDiscountCell.h"

@interface MYDiscountController ()

@property (nonatomic,strong) VOSegmentedControl *segment;
//@property (nonatomic,strong) UITableView    *tableview;
@end

@implementation MYDiscountController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";
    [self createUI];
}

- (void)createUI
{
    _segment = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText:@"可用优惠券"},
                                                              @{VOSegmentText:@"历史优惠券"}]];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DISCOUNT_CELL = @"discount_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DISCOUNT_CELL];
    if (!cell) {
        cell = [[MyDiscountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DISCOUNT_CELL];
    }
    
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

@end