//
//  ExcellentCampSecondCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/11.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentCampSecondCell.h"

@interface ExcellentCampSecondCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UILabel *desLbl;
@property (nonatomic, strong) UIView  *blankView;

@end

@implementation ExcellentCampSecondCell

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
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, kScreenWidth - 20, 80)];
        _desLbl.text = @"第一步：在线申请具体某一期训练营\n第二步：评审团审核，邀请面谈\n第三步：审核通过的项目在线付费\n第五步：如期参加先下训练营";
        _desLbl.font = [UIFont systemFontOfSize:14.0f];
        _desLbl.textColor = [UIColor grayColor];
        _desLbl.numberOfLines = 15;
        
        [self.contentView addSubview:_desLbl];
    }
    
    if (!_blankView) {
        _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, 30)];
        _blankView.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_blankView];
    }
}

@end