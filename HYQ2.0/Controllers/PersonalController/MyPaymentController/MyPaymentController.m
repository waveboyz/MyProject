//
//  MyPaymentController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyPaymentController.h"
#import "VOSegmentedControl.h"
#import "MyPaymentHeader.h"

@interface MyPaymentController ()

@property (nonatomic,strong) MyPaymentHeader *header;
@property (nonatomic,strong) VOSegmentedControl *segment;

@end

@implementation MyPaymentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的提成";
    
    [self createUI];
}

- (void)createUI
{
    _header = [[MyPaymentHeader alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 150)];
    [self.view addSubview:_header];
    
    _segment = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"我的收益"},
                                                              @{VOSegmentText: @"我的推广"}]];
    _segment.frame = CGRectMake(0, 214, kScreenWidth, 40);
    _segment.contentStyle = VOContentStyleTextAlone;
    _segment.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    _segment.backgroundColor = BG_GRAY_COLOR;
    _segment.selectedBackgroundColor = _segment.backgroundColor;
    _segment.allowNoSelection = NO;
    _segment.indicatorThickness = 4;
    _segment.selectedTextColor = NAVIBAR_GREEN_COLOR;
    _segment.selectedIndicatorColor = NAVIBAR_GREEN_COLOR;
    [self.view addSubview:_segment];
    
    self.tableView.frame = CGRectMake(0, 190, kScreenWidth, kScreenHeight - 190);
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
    static NSString *PAYMENT_CELL = @"payment_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PAYMENT_CELL];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PAYMENT_CELL];
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
