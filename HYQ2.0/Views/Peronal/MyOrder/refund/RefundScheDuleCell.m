//
//  RefundScheDuleCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/28.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "RefundScheDuleCell.h"
#import "GlobalConst.h"
#import "OrderModel.h"
#import "UIImageView+WebCache.h"

@interface RefundScheDuleCell ()

@property (nonatomic, strong) UIImageView *imgPic;
@property (nonatomic, strong) UILabel     *titleLbl;
@property (nonatomic, strong) UILabel     *stateLbl;
@property (nonatomic, strong) UILabel     *priceLbl;
@property (nonatomic, strong) UILabel     *cntLbl;
@property (nonatomic, strong) UILabel     *lineLbl;
@property (nonatomic, strong) UIButton    *cancelBtn;
@property (nonatomic, strong) UIView      *blankView;

@end
@implementation RefundScheDuleCell

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

    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(kScreenWidth - 80, 79.5, 75, 30);
        [_cancelBtn setTitle:@"取消退款" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _cancelBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _cancelBtn.layer.borderWidth = 0.5f;
        [_cancelBtn addTarget:self action:@selector(cancelBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_cancelBtn];
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
}

- (void)cancelBtnPressed
{

}

@end