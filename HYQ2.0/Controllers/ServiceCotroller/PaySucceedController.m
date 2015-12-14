//
//  PaySucceedController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/23.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "PaySucceedController.h"
#import "AppDelegate.h"

@interface PaySucceedController ()

@property (nonatomic, strong) UIButton *titleBtn;
@end

@implementation PaySucceedController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleBtn.frame = CGRectMake(kScreenWidth * 0.5 - 70, kScreenHeight * 0.5 - 30, 140, 60);
    [_titleBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [_titleBtn setTitle:@"支付成功！" forState:UIControlStateNormal];
    _titleBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    [_titleBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
    [self.view addSubview:_titleBtn];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStyleDone target:self action:@selector(hideLoginBoard)];
    [self.navigationItem setLeftBarButtonItem:leftBtn animated:YES];
}

- (void)hideLoginBoard
{
    [[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end