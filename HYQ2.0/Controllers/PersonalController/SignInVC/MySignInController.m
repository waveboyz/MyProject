//
//  MySignInController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/30.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MySignInController.h"

@interface MySignInController ()

@property (nonatomic, strong) UIView        *headerView;
@property (nonatomic, strong) UIView        *sectionHeader;
@property (nonatomic, strong) UILabel       *numLbl;

@end

@implementation MySignInController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)createUI
{
    [self.view addSubview:_headerView];

}


- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        _headerView.backgroundColor = NAVIBAR_GREEN_COLOR;
        
        UILabel *desLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 50, 30, 100, 20)];
        desLbl.font = [UIFont systemFontOfSize:10.0f];
        desLbl.textColor = [UIColor whiteColor];
        desLbl.textAlignment = NSTextAlignmentCenter;
        desLbl.text = @"我的积分";
        [_headerView addSubview:desLbl];
        
        _numLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 60, 80, 120, 30)];
        [_headerView addSubview:_numLbl];
    }

    return _headerView;
}
@end
