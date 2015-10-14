//
//  MainServiceCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MainServiceCell.h"

@interface MainServiceCell ()

@property (nonatomic, strong) UIButton      *firstIcon;
@property (nonatomic, strong) UIButton      *secondIcon;
@property (nonatomic, strong) UIButton      *thirdIcon;
@property (nonatomic, strong) UIButton      *forthIcon;
@property (nonatomic, strong) UILabel       *firstLbl;
@property (nonatomic, strong) UILabel       *secondLbl;
@property (nonatomic, strong) UILabel       *thirdLbl;
@property (nonatomic, strong) UILabel       *forthLbl;

@end

@implementation MainServiceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = GRAY_COLOR;
    }

    return self;
}

- (void)setViews
{
    CGFloat IconWidth = (kScreenWidth - 160) / 4;
    CGFloat spaceWidth = 40.0f;
    
    if (!_firstIcon) {
        _firstIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_firstIcon setImage:[UIImage imageNamed:@"main_icon1"] forState:UIControlStateNormal];
        _firstIcon.frame = CGRectMake(20, 10, IconWidth, IconWidth);
        [_firstIcon addTarget:self action:@selector(iconBtnPressedWithTag:) forControlEvents:UIControlEventTouchUpInside];
        _firstIcon.tag = 0;
        _firstIcon.layer.cornerRadius = CGRectGetWidth(_firstIcon.frame) / 2;
        
        [self.contentView addSubview:_firstIcon];
    }
    
    if (!_secondIcon) {
        _secondIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_secondIcon setImage:[UIImage imageNamed:@"main_icon2"] forState:UIControlStateNormal];
        _secondIcon.frame = CGRectMake(spaceWidth + IconWidth + 20, 10, IconWidth, IconWidth);
        [_secondIcon addTarget:self action:@selector(iconBtnPressedWithTag:) forControlEvents:UIControlEventTouchUpInside];
        _secondIcon.tag = 1;
        _secondIcon.layer.cornerRadius = CGRectGetWidth(_secondIcon.frame) / 2;
        
        [self.contentView addSubview:_secondIcon];
    }
    
    if (!_thirdIcon) {
        _thirdIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_thirdIcon setImage:[UIImage imageNamed:@"main_icon3"] forState:UIControlStateNormal];
        _thirdIcon.frame = CGRectMake((spaceWidth + IconWidth) * 2 + 20, 10, IconWidth, IconWidth);
        [_thirdIcon addTarget:self action:@selector(iconBtnPressedWithTag:) forControlEvents:UIControlEventTouchUpInside];
        _thirdIcon.tag = 2;
        _thirdIcon.layer.cornerRadius = CGRectGetWidth(_thirdIcon.frame) / 2;
        
        [self.contentView addSubview:_thirdIcon];
    }
    
    if (!_forthIcon) {
        _forthIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forthIcon setImage:[UIImage imageNamed:@"main_icon4"] forState:UIControlStateNormal];
        _forthIcon.frame = CGRectMake((spaceWidth + IconWidth) * 3 + 20, 10, IconWidth, IconWidth);
        [_forthIcon addTarget:self action:@selector(iconBtnPressedWithTag:) forControlEvents:UIControlEventTouchUpInside];
        _forthIcon.tag = 3;
        _forthIcon.layer.cornerRadius = CGRectGetWidth(_forthIcon.frame) / 2;
        
        [self.contentView addSubview:_forthIcon];
    }
    
    if (!_firstLbl) {
        _firstLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_firstIcon.frame) - 10, 15 + IconWidth, IconWidth + 20, 15)];
        if (IS_IHPONE4 || IS_IPHONE5) {
            _firstLbl.frame = CGRectMake(CGRectGetMinX(_firstIcon.frame) - 10, 15 + IconWidth, IconWidth + 20, 15);
        }
        
        _firstLbl.font = [UIFont systemFontOfSize:12.0f];
        if (IS_IHPONE4 || IS_IPHONE5) {
            _firstLbl.font = [UIFont systemFontOfSize:10.0f];
        }
        _firstLbl.textAlignment = NSTextAlignmentCenter;
        _firstLbl.text = @"优创基地";
        [_firstLbl setCenter:CGPointMake(_firstIcon.center.x, _firstLbl.center.y)];
        
        [self.contentView addSubview:_firstLbl];
    }
    
    if (!_secondLbl) {
        _secondLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_secondIcon.frame) - 10, 15 + IconWidth, IconWidth + 10, 15)];
        _secondLbl.font = [UIFont systemFontOfSize:12.0F];
        if (IS_IHPONE4 || IS_IPHONE5) {
            _secondLbl.font = [UIFont systemFontOfSize:10.0f];
        }
        _secondLbl.textAlignment = NSTextAlignmentCenter;
        _secondLbl.text = @"优创训练营";
        [_secondLbl setCenter:CGPointMake(_secondIcon.center.x, _secondLbl.center.y)];
        
        [self.contentView addSubview:_secondLbl];
    }
    
    if (!_thirdLbl) {
        _thirdLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_thirdIcon.frame) - 10 , 15 + IconWidth, IconWidth + 10, 15)];
        _thirdLbl.font = [UIFont systemFontOfSize:12.0f];
        if (IS_IHPONE4 || IS_IPHONE5) {
            _thirdLbl.font = [UIFont systemFontOfSize:10.0f];
        }
        _thirdLbl.textAlignment = NSTextAlignmentCenter;
        _thirdLbl.text = @"优创金融方案";
        [_thirdLbl setCenter:CGPointMake(_thirdIcon.center.x, _thirdLbl.center.y)];
        
        [self.contentView addSubview:_thirdLbl];
    }
    
    if (!_forthLbl) {
        _forthLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_forthIcon.frame) - 10, 15 + IconWidth, IconWidth + 10, 15)];
        _forthLbl.font = [UIFont systemFontOfSize:12.0f];
        if (IS_IHPONE4 || IS_IPHONE5) {
            _forthLbl.font = [UIFont systemFontOfSize:10.0f];
        }
        _forthLbl.textAlignment = NSTextAlignmentCenter;
        _forthLbl.text = @"优创开放日";
        [_forthLbl setCenter:CGPointMake(_forthIcon.center.x, _forthLbl.center.y)];
        
        [self.contentView addSubview:_forthLbl];
    }
}

- (IBAction)iconBtnPressedWithTag:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *btn = sender;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(iconBtnTouchWithTag:)]) {
            [self.delegate iconBtnTouchWithTag:btn.tag];
        }
    }

}

@end