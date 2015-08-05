//
//  MYDiscountController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MYDiscountController.h"
#import "VOSegmentedControl.h"

@interface MYDiscountController ()

@property (nonatomic,strong) VOSegmentedControl *segment;

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

@end
