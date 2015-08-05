//
//  MyAddressController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyAddressController.h"

@interface MyAddressController ()

@end

@implementation MyAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址管理";
    self.view.backgroundColor = GRAY_COLOR;
    [self createUI];
}

- (void)createUI
{
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]];
    addBtn.frame = CGRectMake(0, kScreenHeight - 60, kScreenWidth, 60);
    [addBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addNewAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)addNewAddress
{
    
}

@end
