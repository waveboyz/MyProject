//
//  ExcellentFinantialSecondCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/11.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentFinantialSecondCell.h"

@interface ExcellentFinantialSecondCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UILabel *desLbl;

@end

@implementation ExcellentFinantialSecondCell

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
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, kScreenWidth - 20, 130)];
        _desLbl.text = @"第一步：用户在好园区平台根据自身的情况合理选择具体金融方案；\n第二步：用户在线递交申请，支付服务费；若未完成融资，服务费无条件退换；若因用户递交的资料不真实导致未完成融资，服务费不退；\n第三步：对用户资料进行初审；\n第四步：约团队进行面谈与进行必要的调研；\n第五步：签约与放款；";
        _desLbl.font = [UIFont systemFontOfSize:14.0f];
        _desLbl.textColor = [UIColor grayColor];
        _desLbl.numberOfLines = 15;
        
        [self.contentView addSubview:_desLbl];
    }
}

@end