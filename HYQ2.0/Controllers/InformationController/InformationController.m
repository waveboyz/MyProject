//
//  InformationController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "InformationController.h"
#import "VOSegmentedControl.h"

@interface InformationController ()

@property (nonatomic, strong) VOSegmentedControl *segment;

@end

@implementation InformationController

- (id) init
{
    if (self = [super init]) {
        self.maxSegCnt = 3;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯活动";
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)createUI
{
    _segment = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText: @"资讯"},
                                                              @{VOSegmentText: @"活动"},
                                                              @{VOSegmentText: @"政策"}]];
    _segment.contentStyle = VOContentStyleTextAlone;
    _segment.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
    _segment.backgroundColor = BG_GRAY_COLOR;
    _segment.selectedBackgroundColor = _segment.backgroundColor;
    _segment.allowNoSelection = NO;
    _segment.frame = CGRectMake(0, 64, kScreenWidth, 40);
    _segment.indicatorThickness = 4;
    _segment.selectedTextColor = NAVIBAR_GREEN_COLOR;
    _segment.selectedIndicatorColor = NAVIBAR_GREEN_COLOR;
    [self.view addSubview:_segment];
    [_segment setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"1: block --> %@", @(index));
        
    }];
    [_segment addTarget:self action:@selector(swipSegmentWithIndexPath:) forControlEvents:UIControlEventValueChanged];
    
    UISwipeGestureRecognizer *rightGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipSegmentToRightGesture)];
    rightGes.direction = UISwipeGestureRecognizerDirectionLeft;

    UISwipeGestureRecognizer *leftGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipSegmentToLeftGesture)];
    
    [self.tableView addGestureRecognizer:leftGes];
    [self.tableView addGestureRecognizer:rightGes];
}

- (void)swipSegmentToLeftGesture
{
    if (_segment.selectedSegmentIndex == 0) {
    }else{
        _segment.selectedSegmentIndex --;
        
        [self.tableView.header beginRefreshing];
        [self loadNewData];
    }
}

- (void)swipSegmentToRightGesture
{
    if (_segment.selectedSegmentIndex == self.maxSegCnt - 1) {
    }else{
        _segment.selectedSegmentIndex ++;
        
        [self.tableView.header beginRefreshing];
        [self loadNewData];
    }
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *INFOR_CELL = @"info_cell";
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:INFOR_CELL];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:INFOR_CELL];
        cell.backgroundColor = ORANGE_COLOR;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end