//
//  ProductAddressCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/22.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ProductAddressCell.h"
#import "GlobalConst.h"
#import "DistrictModel.h"

@interface ProductAddressCell ()

@property (nonatomic, strong) UILabel *detailLbl;
@property (nonatomic, strong) UILabel *lineLbl;

@end

@implementation ProductAddressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BG_GRAY_COLOR;
        [self setViews];
    }
    
    return self;
}

- (void)setViews
{
    if (!_detailLbl) {
        _detailLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, 25)];
        _detailLbl.font = [UIFont systemFontOfSize:15.0f];
        _detailLbl.textColor = [UIColor blackColor];
        _detailLbl.text = @"选择地区";
        [self.contentView addSubview:_detailLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 55, kScreenWidth - 30, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLbl];
    }
}

- (void)setDistrit:(DistrictModel *)distrit
{
    _distrit = distrit;
    
    if (_distrit.location) {
        _detailLbl.text = [NSString stringWithFormat:@"浙江省 杭州市 %@",_distrit.location];
    }
}

@end