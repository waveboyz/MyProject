//
//  MyOrderEvaluateController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyOrderEvaluateController.h"
#import "MyOrderEvaluateResponse.h"
#import "CWStarRateView.h"

#define NAVIBARHEIGHT       64.0f

@interface MyOrderEvaluateController ()
<
    CWStarRateViewDelegate,
    MyOrderEvaluateResponseDelegate
>

@property (nonatomic, strong) NSNumber          *oid;
@property (nonatomic, strong) NSNumber          *settleNO;
@property (nonatomic, strong) CWStarRateView    *starview1;
@property (nonatomic, strong) CWStarRateView    *starview2;
@property (nonatomic, strong) CWStarRateView    *starview3;
@property (nonatomic, strong) CWStarRateView    *starview4;

@end

@implementation MyOrderEvaluateController

- (id)initWithOid:(NSNumber *)oid andWithSettleID:(NSNumber *)settleID
{
    if (self = [super init]) {
        _oid = oid;
        _settleNO = settleID;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"产品评价";
    [self createUI];
}

- (void)createUI
{
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + NAVIBARHEIGHT, kScreenWidth, 30)];
    titleLbl.font = [UIFont systemFontOfSize:17.0f];
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.text = @"给产品服务评分";
    [self.view addSubview:titleLbl];
    
    UILabel *desLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 50 + NAVIBARHEIGHT, 100, 30)];
    desLbl1.font = [UIFont systemFontOfSize:15.0f];
    desLbl1.textColor = [UIColor blackColor];
    desLbl1.text = @"整体满意度";
    [self.view addSubview:desLbl1];
    
    _starview1 = [[CWStarRateView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.5 - 30, CGRectGetMidY(desLbl1.frame) - 10, kScreenWidth * 0.5 - 50, 20) numberOfStars:5];
    _starview1.delegate = self;
    _starview1.hasAnimation = YES;
    [self.view addSubview:_starview1];
    
    UILabel *desLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 90 + NAVIBARHEIGHT, 100, 30)];
    desLbl2.font = [UIFont systemFontOfSize:15.0f];
    desLbl2.textColor = [UIColor blackColor];
    desLbl2.text = @"反应速度";
    [self.view addSubview:desLbl2];

    _starview2 = [[CWStarRateView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 30, CGRectGetMidY(desLbl2.frame) - 10, kScreenWidth * 0.5 - 50, 20) numberOfStars:5];
    _starview2.delegate = self;
    _starview2.hasAnimation = YES;
    [self.view addSubview:_starview2];
    
    UILabel *desLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 130 + NAVIBARHEIGHT, 100, 30)];
    desLbl3.font = [UIFont systemFontOfSize:15.0f];
    desLbl3.textColor = [UIColor blackColor];
    desLbl3.text = @"服务态度";
    [self.view addSubview:desLbl3];

    _starview3 = [[CWStarRateView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 30, CGRectGetMidY(desLbl3.frame) - 10, kScreenWidth * 0.5 - 50, 20) numberOfStars:5];
    _starview3.delegate = self;
    _starview3.hasAnimation = YES;
    [self.view addSubview:_starview3];
    
    UILabel *desLbl4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 170 + NAVIBARHEIGHT, 100, 30)];
    desLbl4.font = [UIFont systemFontOfSize:15.0f];
    desLbl4.textColor = [UIColor blackColor];
    desLbl4.text = @"性价比";
    [self.view addSubview:desLbl4];

    _starview4 = [[CWStarRateView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 30, CGRectGetMidY(desLbl4.frame) - 10, kScreenWidth * 0.5 - 50, 20) numberOfStars:5];
    _starview4.delegate = self;
    _starview4.hasAnimation = YES;
    [self.view addSubview:_starview4];
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49);
    [commitBtn setBackgroundColor:NAVIBAR_GREEN_COLOR];
    [commitBtn setTitle:@"提交评价" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(evaluateOperation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
}

- (void)evaluateOperation
{
    [self showNoTextStateHud];
    NSUInteger value1 = _starview1.scorePercent * 5;
    NSUInteger value2 = _starview2.scorePercent * 5;
    NSUInteger value3 = _starview3.scorePercent * 5;
    NSUInteger value4 = _starview4.scorePercent * 5;
    MyOrderEvaluateResponse *response = [[MyOrderEvaluateResponse alloc] initWithOid:_oid andWithPayID:_settleNO andWithValue1:value1 andWithValue2:value2 andWithValue3:value3 andWithValue4:value4];
    response.delegate = self;
    [response start];
}

- (void)dismissSelf
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(evaluateSucceed)]) {
        [self.delegate evaluateSucceed];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark MyOrderEvaluateResponseDelegate
- (void)evaluateSucceed
{
    [self performSelectorOnMainThread:@selector(showNoTextStateHud) withObject:@"评价成功！" waitUntilDone:YES];
    [self dismissSelf];
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self showStateHudWithText:text];
}

@end