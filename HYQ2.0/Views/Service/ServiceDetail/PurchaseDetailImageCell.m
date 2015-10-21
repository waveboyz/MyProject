//
//  PurchaseDetailImageCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/19.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "PurchaseDetailImageCell.h"
#import "GlobalConst.h"
#import "UIImageView+WebCache.h"
#import "ProductModel.h"
@interface PurchaseDetailImageCell ()

@property (nonatomic, strong) UIImageView   *titleImg;
@property (nonatomic, strong) UILabel       *titleLbl;
@property (nonatomic, strong) UILabel       *desLbl;
@property (nonatomic, strong) UIView       *blankView;
@end

@implementation PurchaseDetailImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setViews
{
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
        [self.contentView addSubview:_titleImg];
    }
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 315, kScreenWidth - 30, 30)];
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_desLbl) {
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 350, kScreenWidth - 30, 25)];
        _desLbl.font = [UIFont systemFontOfSize:17.0f];
        _desLbl.textColor = ORANGE_COLOR;
        [self.contentView addSubview:_desLbl];
    }
    
    if (!_blankView) {
        _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 375, kScreenWidth, 40)];
        _blankView.backgroundColor = BG_GRAY_COLOR;
        [self.contentView addSubview:_blankView];
    }
}

- (void)setProduct:(ProductModel *)product
{
    _product = product;
    if (_product.photo) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",LOCAL_HOST,_product.photo];
        [_titleImg sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"banner_placeholder"]];
    }
    
    if (_product.name) {
        _titleLbl.text = _product.name;
    }
    
    if (![_product.price isEqual:[NSNull null]]) {
        _desLbl.text = [NSString stringWithFormat:@"￥%@",_product.price];
    }
}

@end