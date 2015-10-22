//
//  PurchaseDetailSelectCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/19.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "PurchaseDetailSelectCell.h"
#import "GlobalConst.h"

@interface PurchaseDetailSelectCell ()

@property (nonatomic, strong) UILabel *desLbl;
@property (nonatomic, strong) UILabel *priceLbl;
@property (nonatomic, strong) UIView  *blankView;

@end

@implementation PurchaseDetailSelectCell

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
    if (!_desLbl) {
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth - 150, 25)];
        _desLbl.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_desLbl];
        NSString *str = @"选择 服务类型 搭配产品";
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attriStr setAttributes:@{NSForegroundColorAttributeName:NAVIBAR_GREEN_COLOR,NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} range:NSMakeRange(3, 4)];
        [attriStr setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} range:NSMakeRange(0, 2)];
        [attriStr setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} range:NSMakeRange(8, 4)];
        _desLbl.attributedText = attriStr;
    }
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 145, 15, 130, 25)];
        _priceLbl.font = [UIFont systemFontOfSize:15.0f];
        _priceLbl.textColor = ORANGE_COLOR;
        [self.contentView addSubview:_priceLbl];
    }
    
    if (!_blankView) {
        _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 55, kScreenWidth, 40)];
        _blankView.backgroundColor = BG_GRAY_COLOR;
        [self.contentView addSubview:_blankView];
    }
}

@end