//
//  MyOrderFormCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/13.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyOrderFormCell.h"

@interface MyOrderFormCell ()

@property (nonatomic, strong) UIImageView *imgPic;
@property (nonatomic, strong) UILabel     *titleLbl;
@property (nonatomic, strong) UILabel     *stateLbl;
@property (nonatomic, strong) UILabel     *priceLbl;
@property (nonatomic, strong) UILabel     *cntLbl;
@property (nonatomic, strong) UILabel     *lineLbl;
@property (nonatomic, strong) UIButton    *confirmBtn;
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
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(74, 5, kScreenWidth - 160, 35)];
        _titleLbl.font = [UIFont systemFontOfSize:13.0f];
        _titleLbl.numberOfLines = 2;
        _titleLbl.text = @"这是一个标题所以要长这是一个标题所以要长这是一个标题所以要长";
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_stateLbl) {
        _stateLbl = [[UILabel alloc] initWithFrame:CGRectMake(74, 54, kScreenWidth - 160, 15)];
        _stateLbl.font = [UIFont systemFontOfSize:13.0f];
        _stateLbl.textColor = [UIColor redColor];
        _stateLbl.text = @"交易成功";
        
        [self.contentView addSubview:_stateLbl];
    }
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 5, 60, 15)];
        _priceLbl.font = [UIFont systemFontOfSize:13.0f];
        _priceLbl.text = @"￥260.00";
        _priceLbl.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_priceLbl];
    }
    
    if (!_cntLbl) {
        _cntLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 20, 60, 15)];
        _cntLbl.textAlignment = NSTextAlignmentRight;
        _cntLbl.font = [UIFont systemFontOfSize:13.0f];
        _cntLbl.text = @"X2";
        
        [self.contentView addSubview:_cntLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 74, kScreenWidth - 10, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(kScreenWidth - 105, 79.5, 100, 30);
        [_confirmBtn setTitle:@"确认订单" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:NAVIBAR_GREEN_COLOR forState:UIControlStateNormal];
        _confirmBtn.layer.borderColor = NAVIBAR_GREEN_COLOR.CGColor;
        _confirmBtn.layer.borderWidth = 0.5f;
        
        [self.contentView addSubview:_confirmBtn];
    }
    
    if (!_blankView) {
        _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 114.5, kScreenWidth, 20)];
        _blankView.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_blankView];
    }
}

@end