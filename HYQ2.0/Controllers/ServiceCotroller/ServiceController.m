//
//  FirstViewController.m
//  TestProject
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanTec. All rights reserved.
//

#import "ServiceController.h"
#import "PersonalController.h"
#import "VOSegmentedControl.h"
#import "HYQLoginController.h"

@interface ServiceController ()

@property (nonatomic, strong) VOSegmentedControl *segment;

@end

@implementation ServiceController

- (id)init
{
    if (self = [super init]) {
        self.maxSegCnt = 5;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_icon_person"]
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(showPersonalBtnPressed)];
    [self.navigationItem setLeftBarButtonItem:leftBtn animated:YES];

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

- (void)showPersonalBtnPressed
{
    HYQLoginController *loginVC = [[HYQLoginController alloc] init];
    loginVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:loginVC animated:YES completion:^(void){}];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SERVICE_CELL = @"service_cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:SERVICE_CELL];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SERVICE_CELL];
        cell.backgroundColor = ORANGE_COLOR;
    }

    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end