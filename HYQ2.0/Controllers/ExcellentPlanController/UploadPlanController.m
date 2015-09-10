//
//  UploadPlanController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/12.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "UploadPlanController.h"

#define NAVIBAR_HEIGHT    64.0f
@interface UploadPlanController ()

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *projectField;
@property (nonatomic, strong) UIButton    *btn1;
@property (nonatomic, strong) UIButton    *btn2;
@property (nonatomic, strong) UIButton    *planBtn;
@property (nonatomic, strong) UIButton    *confirmBtn;
@property (nonatomic, strong) UILabel     *line1;
@property (nonatomic, strong) UILabel     *line2;
@property (nonatomic, strong) UILabel     *line3;
@property (nonatomic, strong) UILabel     *line4;
@property (nonatomic, strong) UILabel     *line5;

@end

@implementation UploadPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请加入";
    [self createUI];
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (void)createUI
{
    self.view.backgroundColor = NAVIBAR_GREEN_COLOR;
    CGFloat space = (kScreenHeight - 200) / 4;
    
    
    _nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, space + NAVIBAR_HEIGHT, kScreenWidth - 20, 20)];
    _nameField.textColor = [UIColor whiteColor];
    _nameField.placeholder = @"姓名";
    _nameField.font = [UIFont systemFontOfSize:15.0f];
    
    [self.view addSubview:_nameField];
//    -----
    _line1 = [[UILabel alloc] initWithFrame:CGRectMake(10, space + 20 + NAVIBAR_HEIGHT, kScreenWidth - 20, 1)];
    _line1.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_line1];
//    -----
    _phoneField = [[UITextField alloc] initWithFrame:CGRectMake(10, space + 21 + NAVIBAR_HEIGHT, kScreenWidth - 20, 20)];
    _phoneField.textColor = [UIColor whiteColor];
    _phoneField.placeholder = @"手机号";
    _phoneField.font = [UIFont systemFontOfSize:15.0f];
    
    [self.view addSubview:_phoneField];
//    -----
    [self.view addSubview:_phoneField];
    _line2 = [[UILabel alloc] initWithFrame:CGRectMake(10, space + 41 + NAVIBAR_HEIGHT, kScreenWidth - 20, 1)];
    _line2.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_line2];
//    -----
    _projectField = [[UITextField alloc] initWithFrame:CGRectMake(10, space + 42 + NAVIBAR_HEIGHT, kScreenWidth - 20, 20)];
    _projectField.textColor = [UIColor whiteColor];
    _projectField.placeholder = @"项目名称";
    _projectField.font = [UIFont systemFontOfSize:15.0f];
    
    [self.view addSubview:_projectField];
//    -----
    _line3 = [[UILabel alloc] initWithFrame:CGRectMake(10, space + 62 + NAVIBAR_HEIGHT, kScreenWidth - 20, 1)];
    _line3.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_line3];
//    -----
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn1.frame = CGRectMake(10, 1.5 * space + 63 + NAVIBAR_HEIGHT, kScreenWidth - 20, 20);
    _btn1.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_btn1 setTitle:@"所属行业" forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self.view addSubview:_btn1];
//    -----
    _line4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 1.5 * space + 83 + NAVIBAR_HEIGHT, kScreenWidth - 20, 1)];
    _line4.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_line4];
//    -----
    _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn2.frame = CGRectMake(10, 1.5 * space + 84 + NAVIBAR_HEIGHT, kScreenWidth - 20, 20);
    _btn2.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_btn2 setTitle:@"选择申请基地" forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self.view addSubview:_btn2];
//    -----
    _line5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 1.5 * space + 104 + NAVIBAR_HEIGHT, kScreenWidth - 20, 1)];
    _line5.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_line5];
//    -----
    _planBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _planBtn.frame = CGRectMake(10, 1.75 * space + 104 + NAVIBAR_HEIGHT, kScreenWidth - 20, 20);
    _planBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_planBtn setTitle:@"点击上传商业计划书" forState:UIControlStateNormal];
    [_planBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _planBtn.layer.borderWidth = 0.5;
    _planBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self.view addSubview:_planBtn];
//    -----
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(10, 2.25 * space + 124 + NAVIBAR_HEIGHT, kScreenWidth - 20, 20);
    _confirmBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _confirmBtn.layer.cornerRadius = 10;
    [_confirmBtn setTitle:@"确认申请" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:_confirmBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:tap];
}

- (void)hideKeyBoard
{
    [self.view endEditing:YES];

}

@end