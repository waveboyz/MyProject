//
//  ExcellentHeaderCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/5.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentHeaderCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface ExcellentHeaderCell ()

@property (nonatomic, strong) UIImageView   *headerView;
@property (nonatomic, strong) UILabel       *titleLbl;
@property (nonatomic, strong) UIButton      *firstIcon;
@property (nonatomic, strong) UIButton      *secondIcon;
@property (nonatomic, strong) UIButton      *thirdIcon;
@property (nonatomic, strong) UIButton      *forthIcon;
@property (nonatomic, strong) UILabel       *firstLbl;
@property (nonatomic, strong) UILabel       *secondLbl;
@property (nonatomic, strong) UILabel       *thirdLbl;
@property (nonatomic, strong) UILabel       *forthLbl;
@property (nonatomic, strong) UIView        *grayview;

@end

@implementation ExcellentHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setViews];
    }
    
    return self;
}

- (void)setViews
{
    CGFloat IconWidth = (kScreenWidth - 160) / 4;
    CGFloat spaceWidth = 40.0f;
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        [_headerView sd_setImageWithURL:[NSURL URLWithString:@"http://f8.topit.me/8/ed/67/110248312730a67ed8o.jpg"]placeholderImage:[UIImage imageNamed:@"notice_place_holder"]];
        [self.contentView addSubview:_headerView];
    }

    if (!_grayview) {
        _grayview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        _grayview.backgroundColor = [UIColor blackColor];
        _grayview.alpha = 0.2f;
        
        [self.contentView addSubview:_grayview];
    }
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMidY(_headerView.frame) - 60, kScreenWidth - 20, 120)];
        _titleLbl.font = [UIFont systemFontOfSize:14.0f];
        _titleLbl.textAlignment = NSTextAlignmentLeft;
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.numberOfLines = 6;
        _titleLbl.text = @"优创计划是好园区与搜钱网联合知名的投资机构、强大倒是团打造的优秀创新项目综合成长培育计划，计划花3年时间在全国100个园区培育1000个企业价值过亿的项目的行动计划，简称“311优创计划”，旨在为创新企业者们打造一条可复制、可执行，成功率更高的成长道路。";
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_firstIcon) {
        _firstIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_firstIcon setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _firstIcon.frame = CGRectMake(20, 165, IconWidth, IconWidth);
        [_firstIcon addTarget:self action:@selector(iconBtnPressedWithTag:) forControlEvents:UIControlEventTouchUpInside];
        _firstIcon.tag = 0;
        
        [self.contentView addSubview:_firstIcon];
    }
    
    if (!_secondIcon) {
        _secondIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_secondIcon setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _secondIcon.frame = CGRectMake(spaceWidth + IconWidth + 20, 165, IconWidth, IconWidth);
        [_secondIcon addTarget:self action:@selector(iconBtnPressedWithTag:) forControlEvents:UIControlEventTouchUpInside];
        _secondIcon.tag = 1;
        
        [self.contentView addSubview:_secondIcon];
    }
    
    if (!_thirdIcon) {
        _thirdIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_thirdIcon setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _thirdIcon.frame = CGRectMake((spaceWidth + IconWidth) * 2 + 20, 165, IconWidth, IconWidth);
        [_thirdIcon addTarget:self action:@selector(iconBtnPressedWithTag:) forControlEvents:UIControlEventTouchUpInside];
        _thirdIcon.tag = 2;
        
        [self.contentView addSubview:_thirdIcon];
    }
    
    if (!_forthIcon) {
        _forthIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forthIcon setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _forthIcon.frame = CGRectMake((spaceWidth + IconWidth) * 3 + 20, 165, IconWidth, IconWidth);
        [_forthIcon addTarget:self action:@selector(iconBtnPressedWithTag:) forControlEvents:UIControlEventTouchUpInside];
        _forthIcon.tag = 3;
        
        [self.contentView addSubview:_forthIcon];
    }
    
    if (!_firstLbl) {
        _firstLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_firstIcon.frame) - 10, 165 + IconWidth, IconWidth + 20, 15)];
        if (IS_IHPONE4 || IS_IPHONE5) {
            _firstLbl.frame = CGRectMake(CGRectGetMinX(_firstIcon.frame) - 10, 165 + IconWidth, IconWidth + 20, 15);
        }
        
        _firstLbl.font = [UIFont systemFontOfSize:12.0f];
        if (IS_IHPONE4 || IS_IPHONE5) {
            _firstLbl.font = [UIFont systemFontOfSize:10.0f];
        }
        _firstLbl.textAlignment = NSTextAlignmentCenter;
        _firstLbl.text = @"优创金融方案";
        [_firstLbl setCenter:CGPointMake(_firstIcon.center.x, _firstLbl.center.y)];
        
        [self.contentView addSubview:_firstLbl];
    }
    
    if (!_secondLbl) {
        _secondLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_secondIcon.frame) - 10, 165 + IconWidth, IconWidth + 10, 15)];
        _secondLbl.font = [UIFont systemFontOfSize:12.0F];
        if (IS_IHPONE4 || IS_IPHONE5) {
            _secondLbl.font = [UIFont systemFontOfSize:10.0f];
        }
        _secondLbl.textAlignment = NSTextAlignmentCenter;
        _secondLbl.text = @"优创基地";
        [_secondLbl setCenter:CGPointMake(_secondIcon.center.x, _secondLbl.center.y)];
        
        [self.contentView addSubview:_secondLbl];
    }
    
    if (!_thirdLbl) {
        _thirdLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_thirdIcon.frame) - 10 , 165 + IconWidth, IconWidth + 10, 15)];
        _thirdLbl.font = [UIFont systemFontOfSize:12.0f];
        if (IS_IHPONE4 || IS_IPHONE5) {
            _thirdLbl.font = [UIFont systemFontOfSize:10.0f];
        }
        _thirdLbl.textAlignment = NSTextAlignmentCenter;
        _thirdLbl.text = @"优创训练营";
        [_thirdLbl setCenter:CGPointMake(_thirdIcon.center.x, _thirdLbl.center.y)];
        
        [self.contentView addSubview:_thirdLbl];
    }
    
    if (!_forthLbl) {
        _forthLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_forthIcon.frame) - 10, 165 + IconWidth, IconWidth + 10, 15)];
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
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(iconTouchedWithTag:)]) {
            [self.delegate iconTouchedWithTag:btn.tag];
        }
    }
}

@end
