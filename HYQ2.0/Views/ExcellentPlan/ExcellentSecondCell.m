//
//  ExcellentSecondCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/5.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentSecondCell.h"

@interface ExcellentSecondCell ()
@property (nonatomic, strong)UILabel *titleLbl;
@property (nonatomic, strong)UILabel *desLbl;
@property (nonatomic, strong)UILabel *lineLbl;

@end

@implementation ExcellentSecondCell

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
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth, 30)];
        _titleLbl.text = @"我们的优势";
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
        _desLbl.text = @"将通过对参加的项目进行包括""优创金融方案、优创基地、优创训练营、优创开放日""等环节进行培育辅导最终完成项目的孵化、加速、成熟的成长壮大过程。";
        _desLbl.font = [UIFont systemFontOfSize:12.0f];
        _desLbl.textColor = [UIColor grayColor];
        _desLbl.numberOfLines = 3;
        
        [self.contentView addSubview:_desLbl];
    }
}

@end
