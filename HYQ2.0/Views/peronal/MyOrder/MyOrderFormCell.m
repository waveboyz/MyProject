//
//  MyOrderFormCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/13.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyOrderFormCell.h"
#import "UIImageView+WebCache.h"

@interface MyOrderFormCell ()

@property (nonatomic, strong) UIImageView *imgPic;
@property (nonatomic, strong) UILabel     *titleLbl;
@property (nonatomic, strong) UILabel     *stateLbl;
@property (nonatomic, strong) UILabel     *priceLbl;
@property (nonatomic, strong) UILabel     *cntLbl;
@property (nonatomic, strong) UILabel     *lineLbl;
@property (nonatomic, strong) UIButton    *confirmBtn;
@property (nonatomic, strong) UIButton    *evalueBtn;
@property (nonatomic, strong) UIButton    *payBtn;
@property (nonatomic, strong) UIView      *blankView;

@end

@implementation MyOrderFormCell

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
    
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(kScreenWidth - 115, 79.5, 50, 30);
        [_confirmBtn setTitle:@"查看" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
        _confirmBtn.layer.borderColor = NAVIBAR_GREEN_COLOR.CGColor;
        _confirmBtn.layer.borderWidth = 0.5f;
        
        [self.contentView addSubview:_confirmBtn];
    }
    
    if (!_evalueBtn) {
        _evalueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _evalueBtn.frame = CGRectMake(kScreenWidth - 55, 79.5, 50, 30);
        [_evalueBtn setTitle:@"评价" forState:UIControlStateNormal];
        [_evalueBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
        _evalueBtn.layer.borderColor = NAVIBAR_GREEN_COLOR.CGColor;
        _evalueBtn.layer.borderWidth = 0.5f;
        
        [self.contentView addSubview:_evalueBtn];
    }
    
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.frame = CGRectMake(kScreenWidth - 55, 79.5, 50, 30);
        [_payBtn setTitle:@"付款" forState:UIControlStateNormal];
        [_payBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
        _payBtn.layer.borderColor = NAVIBAR_GREEN_COLOR.CGColor;
        _payBtn.layer.borderWidth = 0.5f;
        
        [self.contentView addSubview:_payBtn];
    }
    
    if (!_blankView) {
        _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 114.5, kScreenWidth, 20)];
        _blankView.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_blankView];
    }
}

- (void)setOrder:(OrderModel *)order
{
    _order = order;
    //----------------------------------
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",LOCAL_HOST,_order.photo];
    [_imgPic sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"product_placeholder"]];
    //----------------------------------
    _titleLbl.text = _order.name;
    //----------------------------------
    NSString *money = [_order.money stringValue];
    _priceLbl.text = [NSString stringWithFormat:@"￥%@",money];
    //----------------------------------
    _cntLbl.text = [NSString stringWithFormat:@"X%@",_order.num];
    //---------------------------------
    _stateLbl.text = _order.statusMsg;
    
    if ([_order.statusBtn isEqualToString:@"待付款"]) {
        _confirmBtn.hidden = YES;
        _evalueBtn.hidden = YES;
    }else if ([_order.statusBtn isEqualToString:@"评价"]){
        _payBtn.hidden = YES;
        _confirmBtn.frame = CGRectMake(kScreenWidth - 115, 79.5, 50, 30);
    }else if([_order.statusBtn isEqualToString:@"查看"]){
        _payBtn.hidden = YES;
        _evalueBtn.hidden = YES;
        _confirmBtn.frame = CGRectMake(kScreenWidth - 55, 79.5, 50, 30);
    }
}

@end