//
//  ExcellentBaseThirdCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/11.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentBaseThirdCell.h"

@interface ExcellentBaseThirdCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UILabel *desLbl;

@end
@implementation ExcellentBaseThirdCell

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
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, kScreenWidth - 20, 170)];
        _desLbl.textAlignment = NSTextAlignmentCenter;
        _desLbl.font = [UIFont systemFontOfSize:14.0f];
        _desLbl.textColor = [UIColor grayColor];
        _desLbl.numberOfLines = 16;
        _desLbl.text = @"最的0租金，独立物理办公空间\n\n最近距离接触2000位投资人\n\n最快速1个月即可获得投资\n\n最全面享受14大服务模块\n\n最贴心专属行政助理\\拎包入驻，一年省20万开支\n\n最自由选择，全杭州布局，20余场地任你选";
        
        [self.contentView addSubview:_desLbl];
    }
}

@end