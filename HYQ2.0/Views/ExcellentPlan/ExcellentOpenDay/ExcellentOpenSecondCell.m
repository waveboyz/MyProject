//
//  ExcellentOpenSecondCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/11.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentOpenSecondCell.h"

@interface ExcellentOpenSecondCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UILabel *desLbl;
@property (nonatomic, strong) UIView  *blankView;

@end

@implementation ExcellentOpenSecondCell

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
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 20, 30)];
        _titleLbl.text = @"服务流程";
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blueColor];
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, kScreenWidth - 20, 0.5)];
        _lineLbl.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_desLbl) {
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, kScreenWidth - 20, 120)];
        _desLbl.text = @"第一步：在线报名并提交项目计划书。\n第二步：专家团针对项目进行初步评审，第一轮筛选。\n第三步：在第一轮筛选通过的项目中，邀约项目面谈复审。\n第四步：通过筛选的项目由专业导师团进行创业辅导。\n第五步：经过1-6个月孵化，符合条件的项目进入天使有约开放日公开路演。";
        _desLbl.font = [UIFont systemFontOfSize:14.0f];
        _desLbl.textColor = [UIColor grayColor];
        _desLbl.numberOfLines = 15;
        
        [self.contentView addSubview:_desLbl];
    }
    
    if (!_blankView) {
        _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 190, kScreenWidth, 30)];
        _blankView.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_blankView];
    }
}

@end
