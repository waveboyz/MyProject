//
//  InformationController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "InformationController.h"
#import "VOSegmentedControl.h"
#import "ActivityCell.h"

@interface InformationController ()

@property (nonatomic, strong) VOSegmentedControl *segment;

@end

@implementation InformationController

- (id) init
{
    if (self = [super init]) {

    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯活动";
    [self createUI];
}

- (void)createUI
{
    _segment = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"资讯"},
                                                              @{VOSegmentText: @"活动"},
                                                              @{VOSegmentText: @"政策"}]];
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
    if (_segment.selectedSegmentIndex == self.maxSegCnt - 1){
        return;
    }
    else{
        [_segment setSegment:nil atIndex:(_segment.selectedSegmentIndex +1)];
    }
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *INFOR_CELL = @"info_cell";
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:INFOR_CELL];
    if (!cell) {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:INFOR_CELL];
    }

    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.5f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end