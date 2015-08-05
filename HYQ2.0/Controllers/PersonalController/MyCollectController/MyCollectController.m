//
//  MyCollectController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyCollectController.h"

@interface MyCollectController ()

@end

@implementation MyCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self createUI];
}

- (void)createUI
{
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editBtnPressed)];
    [self.navigationItem setRightBarButtonItem:editItem];
}

- (void)editBtnPressed
{

}

@end
