//
//  ExcellentThirdCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/5.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentThirdCell.h"

@interface ExcellentThirdCell ()

@property (nonatomic, strong)UILabel *titleLbl;
@property (nonatomic, strong)UILabel *lineLbl;
@property (nonatomic, strong)UILabel *desLbl;

@end

@implementation ExcellentThirdCell

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
        _titleLbl.text = @"加入流程";
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
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, kScreenWidth - 20, 75)];

        _desLbl.text = @"第一步：提出申请\n第二步：填写入驻申请书\n第三步：等待审核\n第四步：完成申请";
        _desLbl.font = [UIFont systemFontOfSize:12.0f];
        _desLbl.textColor = [UIColor grayColor];
        _desLbl.numberOfLines = 5;
        
        [self.contentView addSubview:_desLbl];
    }
}

@end
