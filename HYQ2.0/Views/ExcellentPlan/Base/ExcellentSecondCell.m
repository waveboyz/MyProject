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
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 20, 30)];
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
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, kScreenWidth - 20, 240)];
        if (IS_IHPONE4||IS_IPHONE5) {
            _desLbl.frame = CGRectMake(10, 55, kScreenWidth - 20, 220);
        }
        _desLbl.text = @"1、最值得信赖的平台：依托拱墅区中小企业服务联盟、科技局.科协、浙江省天使投资企业委员会，打造值得信赖的社会化中小企业服务体系。\n\n2、最完成孵化体系：解决项目从办公、融资、培训到服务等创业过程中遇到的所有问题、环环相扣促使更快速成长。\n\n3、最强大的投融资资源：平台已聚集2000位投资人、最快速与资金方建立联系、获取资金支持。\n\n4、最全面的服务体系：好园区中国首家园区O2O服务商，涵盖政策咨询、财会代理、法律咨询、知识产权、工商注册、项目申报等一站式服务创业项目。";
        _desLbl.font = [UIFont systemFontOfSize:14.0f];
        _desLbl.textColor = [UIColor grayColor];
        _desLbl.numberOfLines = 18;
        
        [self.contentView addSubview:_desLbl];
    }
}

@end
