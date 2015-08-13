//
//  ExcellentOpenFirstCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/11.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentOpenFirstCell.h"
#import "UIImageView+WebCache.h"

@interface ExcellentOpenFirstCell ()

@property (nonatomic, strong) UIImageView   *headerView;
@property (nonatomic, strong) UILabel       *titleLbl;
@property (nonatomic, strong) UIView        *grayview;

@end

@implementation ExcellentOpenFirstCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
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
        _titleLbl.font = [UIFont systemFontOfSize:14.0f];
        _titleLbl.textAlignment = NSTextAlignmentLeft;
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.numberOfLines = 5;
        _titleLbl.text = @"优创训练营季节各路行业大咖、创业导师，为创业创新公司提供创业“36计”、“18般武艺”培训，其中包括商业模式设计、技术支持方案、营销运营、融资技巧、商务洽谈，让创业者在创业中少走弯路，以最快的速度成功创业";
        
        [self.contentView addSubview:_titleLbl];
    }
}
@end
