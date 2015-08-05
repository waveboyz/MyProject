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

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) VOSegmentedControl *segment;
@end

@implementation ServiceController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
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
}

- (void)showPersonalBtnPressed
{
    HYQLoginController *loginVC = [[HYQLoginController alloc] init];
    loginVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:loginVC animated:YES completion:^(void){}];
}

@end
