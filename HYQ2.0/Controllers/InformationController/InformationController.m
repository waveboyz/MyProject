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
}

@end
