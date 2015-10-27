//
//  OrderDetailCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/26.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "OrderDetailCell.h"
#import "UIImageView+WebCache.h"

@interface OrderDetailCell ()

@property (nonatomic, strong) UIImageView *imgPic;
@property (nonatomic, strong) UILabel     *titleLbl;
@property (nonatomic, strong) UILabel     *stateLbl;
@property (nonatomic, strong) UILabel     *priceLbl;
@property (nonatomic, strong) UILabel     *cntLbl;
@property (nonatomic, strong) UILabel     *lineLbl;
@property (nonatomic, strong) UIButton    *refundBtn;
@property (nonatomic, strong) UIButton    *purchaseBtn;
@property (nonatomic, strong) UIView      *blankView;

@end
@implementation OrderDetailCell

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
    if (!_imgPic) {
        _imgPic = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 64, 64)];
        _imgPic.image = [UIImage imageNamed:@"product_placeholder"];
        
        [self.contentView addSubview:_imgPic];
    }
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(74, 0, kScreenWidth - 160, 30)];
        _titleLbl.font = [UIFont systemFontOfSize:13.0f];
        _titleLbl.numberOfLines = 2;
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_stateLbl) {
        _stateLbl = [[UILabel alloc] initWithFrame:CGRectMake(74, 54, kScreenWidth - 160, 15)];
        _stateLbl.font = [UIFont systemFontOfSize:13.0f];
        _stateLbl.textColor = [UIColor redColor];
        
        [self.contentView addSubview:_stateLbl];
    }
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 5, 60, 15)];
        _priceLbl.font = [UIFont systemFontOfSize:13.0f];
        _priceLbl.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_priceLbl];
    }
    
    if (!_cntLbl) {
        _cntLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 20, 60, 15)];
        _cntLbl.textAlignment = NSTextAlignmentRight;
        _cntLbl.font = [UIFont systemFontOfSize:13.0f];
        
        [self.contentView addSubview:_cntLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 74, kScreenWidth - 10, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_refundBtn) {
        _refundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _refundBtn.frame = CGRectMake(kScreenWidth - 165, 79.5, 75, 30);
        [_refundBtn setTitle:@"申请退款" forState:UIControlStateNormal];
        [_refundBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _refundBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _refundBtn.layer.borderWidth = 0.5f;
        //        [_purchaseBtn addTarget:self action:@selector(purchaseBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_refundBtn];
    }
    if (!_purchaseBtn) {
        _purchaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _purchaseBtn.frame = CGRectMake(kScreenWidth - 80, 79.5, 75, 30);
        [_purchaseBtn setTitle:@"继续购买" forState:UIControlStateNormal];
        [_purchaseBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
        _purchaseBtn.layer.borderColor = NAVIBAR_GREEN_COLOR.CGColor;
        _purchaseBtn.layer.borderWidth = 0.5f;
        [_purchaseBtn addTarget:self action:@selector(purchaseBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_purchaseBtn];
    }
}

- (void)setOrder:(OrderModel *)order
{
    _order = order;
    //----------------------------------
    if (_order.photo) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",LOCAL_HOST,_order.photo];
        [_imgPic sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"product_placeholder"]];
    }
    //----------------------------------
    if (_order.name) {
        _titleLbl.text = _order.name;
    }
    //----------------------------------
    if (_order.money != nil) {
        NSString *money = [_order.money stringValue];
        _priceLbl.text = [NSString stringWithFormat:@"￥%@",money];
    }
    //----------------------------------
    if (_order.num) {
        _cntLbl.text = [NSString stringWithFormat:@"X%@",_order.num];
    }
    //---------------------------------
    if (_order.statusMsg) {
        _stateLbl.text = _order.statusMsg;
    }
    
    if ([_order.statusMsg isEqualToString:@"服务结束"]) {
        _refundBtn.hidden = YES;
    }
}

- (void)purchaseBtnPressed
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(purchaseBtnTouched)]) {
        [self.delegate purchaseBtnTouched];
    }
}

@end