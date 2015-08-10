//
//  EcellentBaseFirstCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/10.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentBaseFirstCell.h"
#import "UIImageView+WebCache.h"

@interface ExcellentBaseFirstCell ()

@property (nonatomic, strong) UIImageView   *headerView;
@property (nonatomic, strong) UILabel       *titleLbl;
@property (nonatomic, strong) UIView        *grayview;

@end

@implementation ExcellentBaseFirstCell

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
        _titleLbl.font = [UIFont systemFontOfSize:12.0f];
        _titleLbl.textAlignment = NSTextAlignmentLeft;
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.numberOfLines = 5;
        _titleLbl.text = @"不仅是物理办公空调，更是一站式获取创业服务的家园。全杭州布局拎包入驻\\专属行政秘书";
        
        [self.contentView addSubview:_titleLbl];
    }
}

@end