//
//  MyPaymentHeader.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyPaymentHeader.h"
#import "HYQUserManager.h"

@interface MyPaymentHeader ()

@property (nonatomic,strong) UILabel    *desLbl;
@property (nonatomic,strong) UILabel    *propertyLbl;
@property (nonatomic,strong) UIButton   *withdrawBtn;

@end

@implementation MyPaymentHeader

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setViews];
    }
    
    return self;
}

- (void)setViews
{
    self.backgroundColor = NAVIBAR_GREEN_COLOR;
    
    _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 40, 10, 80, 20)];
    _desLbl.font = [UIFont systemFontOfSize:13.0f];
    _desLbl.textColor = [UIColor whiteColor];
    _desLbl.textAlignment = NSTextAlignmentCenter;
    _desLbl.text = @"余额（元）";
    [self addSubview:_desLbl];
    
    _propertyLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 60, 40, 120, 40)];
    _propertyLbl.font = [UIFont systemFontOfSize:31.0f];
    _propertyLbl.textColor = [UIColor whiteColor];
    _propertyLbl.textAlignment = NSTextAlignmentCenter;
    NSNumber *property = [[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"property"];
    _propertyLbl.text = [property stringValue];
    [self addSubview:_propertyLbl];
    
    _withdrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _withdrawBtn.frame = CGRectMake(kScreenWidth * 0.5 - 40, 100, 80, 30);
    _withdrawBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _withdrawBtn.layer.borderWidth = 0.5;
    _withdrawBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [_withdrawBtn setImage:[UIImage imageNamed:@"cash_icon"] forState:UIControlStateNormal];
    [_withdrawBtn setTitle:@"转入余额" forState:UIControlStateNormal];
    [_withdrawBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_withdrawBtn];
}

@end