//
//  BaseViewController.m
//  HYQ
//
//  Created by 周翔 on 15/6/17.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BG_GRAY_COLOR;
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    // Do any additional setup after loading the view.
}

//给子类重写
- (void)createUI
{
    
}

- (void)showStateHudWithText:(NSString *)text
{
    if (!self.stateHud) {
        _stateHud = [[MBProgressHUD alloc] initWithView:self.view];
        _stateHud.delegate = self;
        [self.view addSubview:_stateHud];
    }
    self.stateHud.mode = MBProgressHUDModeText;
    self.stateHud.opacity = 0.6;
    self.stateHud.labelText = text;
    self.stateHud.labelFont = [UIFont systemFontOfSize:12.0f];
    [self.stateHud show:YES];
    [self.stateHud hide:YES afterDelay:1.2];
    self.stateHud = nil;
}

- (void)showNoTextStateHud
{
    if (!self.stateHud) {
        self.stateHud = [[MBProgressHUD alloc] initWithView:self.view];
        self.stateHud.delegate = self;
        [self.view addSubview:self.stateHud];
    }
    
    self.stateHud.mode = MBProgressHUDModeIndeterminate;
    self.stateHud.opacity = 0.6;
    [self.stateHud show:YES];
}

- (void)stopStateHud
{
    [self.stateHud hide:YES afterDelay:0.5];
    self.stateHud = nil;
}

@end