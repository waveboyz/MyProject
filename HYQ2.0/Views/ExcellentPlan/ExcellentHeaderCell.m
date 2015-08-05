//
//  ExcellentHeaderCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/5.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentHeaderCell.h"

@interface ExcellentHeaderCell ()

@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UIView      *blurview;
@property (nonatomic, strong) UILabel     *titleLbl;
@property (nonatomic, strong) UIImageView *firstIcon;
@property (nonatomic, strong) UIImageView *secondIcon;
@property (nonatomic, strong) UIImageView *thirdIcon;
@property (nonatomic, strong) UIImageView *forthIcon;
@property (nonatomic, strong) UILabel     *firstLbl;
@property (nonatomic, strong) UILabel     *secondLbl;
@property (nonatomic, strong) UILabel     *thirdLbl;
@property (nonatomic, strong) UILabel     *forthLbl;

@end

@implementation ExcellentHeaderCell

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
        
        [self.contentView addSubview:_headerView];
    }
    
    if (!_blurview) {
        _blurview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        
        [self.contentView addSubview:_blurview];
    }
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMidY(_headerView.frame) - 60, kScreenWidth - 20, 120)];
        _titleLbl.font = [UIFont systemFontOfSize:15.0f];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.text = @"将通过对参加的项目进行包括""优创金融方案、有床基地、优创训练营、优创开放日""等环节进行培育辅导最终完成项目的孵化、加速、成熟的成长壮大过程";
        
        [self.contentView addSubview:_titleLbl];
    }
}

@end
