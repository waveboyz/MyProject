//
//  PurchaseDetailCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/19.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "PurchaseDetailCell.h"
#import "GlobalConst.h"
#import "ProductModel.h"
#import "CalculateHeight.h"
@interface PurchaseDetailCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UILabel *detailLbl;

@end

@implementation PurchaseDetailCell

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
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth * 0.5, 30)];
        _titleLbl.font = [UIFont systemFontOfSize:15.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"产品详情";
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, kScreenWidth - 30, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_detailLbl) {
        _detailLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, kScreenWidth - 30, 200)];
        _detailLbl.font = [UIFont systemFontOfSize:15.0f];
        _detailLbl.textColor = [UIColor blackColor];
        _detailLbl.numberOfLines = 20;
        [self.contentView addSubview:_detailLbl];
    }
}

- (void)setProduct:(ProductModel *)product
{
    _product = product;
    if (_product.contentText) {
        CGFloat height = [[CalculateHeight calculate] calculateHeightWithString:_product.contentText];
        _detailLbl.text = _product.contentText;
        _detailLbl.frame = CGRectMake(15, 70, kScreenWidth - 30, height);
    }
}
@end