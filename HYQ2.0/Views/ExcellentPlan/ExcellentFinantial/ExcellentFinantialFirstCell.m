//
//  ExcellentFinantialFirstCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/11.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentFinantialFirstCell.h"
#import "UIImageView+WebCache.h"

@interface ExcellentFinantialFirstCell ()

@property (nonatomic, strong) UIImageView   *headerView;
@property (nonatomic, strong) UILabel       *titleLbl;
@property (nonatomic, strong) UIView        *grayview;
@property (nonatomic, strong) UIView        *blankView;

@end

@implementation ExcellentFinantialFirstCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setViews
{
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        _headerView.image = [UIImage imageNamed:@"excellent_plan"];
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
        _titleLbl.numberOfLines = 5;
        _titleLbl.text = @"不仅是物理办公空调，更是一站式获取创业服务的家园。全杭州布局拎包入驻\\专属行政秘书";
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_blankView) {
        _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, 30)];
        _blankView.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_blankView];
    }
}

@end
