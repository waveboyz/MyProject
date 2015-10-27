//
//  ProductSelectImgCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ProductSelectImgCell.h"
#import "GlobalConst.h"
#import "ProductModel.h"
#import "ProductComboModel.h"
#import "ProductTypeModel.h"
#import "UIImageView+WebCache.h"

@interface ProductSelectImgCell ()

@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *priceLbl;
@property (nonatomic, strong) UILabel *desLbl;
@property (nonatomic, strong) UILabel *lineLbl;

@end

@implementation ProductSelectImgCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BG_GRAY_COLOR;
        _comboArr = [NSMutableArray new];
        [self setViews];
    }
    
    return self;
}

- (void)setViews
{
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30, 90, 90)];
        [self.contentView addSubview:_titleImg];
    }
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(115, 30, kScreenWidth - 130, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(115, 65, kScreenWidth - 130, 25)];
        _priceLbl.font = [UIFont systemFontOfSize:20.0f];
        _priceLbl.textColor = ORANGE_COLOR;
        [self.contentView addSubview:_priceLbl];
    }
    
    if (!_desLbl) {
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(115, 100, kScreenWidth - 130, 20)];
        _desLbl.font = [UIFont systemFontOfSize:15.0f];
        _desLbl.textColor = [UIColor blackColor];
        [self.contentView addSubview:_desLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 150, kScreenWidth - 30, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLbl];
    }
}

- (void)setProduct:(ProductModel *)product
{
    _product = product;
    if (_product.photo) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",LOCAL_HOST,_product.photo];
        [_titleImg sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"product_placeholder"]];
    }
    
    if (_product.name) {
        _titleLbl.text = _product.name;
    }
    
    if (_product.price) {
        _priceLbl.text = [NSString stringWithFormat:@"￥%@",_product.price];
    }
}

- (void)setType:(ProductTypeModel *)type
{
    _type = type;
    [self reloadDesLable];
}

- (void)setComboArr:(NSMutableArray *)comboArr
{
    _comboArr = comboArr;
    [self reloadDesLable];
}

- (void)reloadDesLable
{
    NSMutableString *str = [NSMutableString new];
    
    NSInteger price = [_type.price integerValue];
    
    for (ProductComboModel *combo in _comboArr) {
        price += [combo.pdrice integerValue];
    }
    _priceLbl.text = [NSString stringWithFormat:@"￥%ld",price];
    
    if (_type && _comboArr.count) {
        for (ProductComboModel *combo in _comboArr) {
            [str appendFormat:@"%@ ",combo.pdname];
        }
        
        _desLbl.text = [NSString stringWithFormat:@"已选：“%@”，“%@”",_type.psname,str];
    }else if (_type){
        _desLbl.text = [NSString stringWithFormat:@"已选：“%@”",_type.psname];
    }else if (_comboArr.count){
        for (ProductComboModel *combo in _comboArr) {
            [str appendFormat:@"%@ ",combo.pdname];
        }
        
        _desLbl.text = [NSString stringWithFormat:@"已选：“%@”",str];
    }
}

@end