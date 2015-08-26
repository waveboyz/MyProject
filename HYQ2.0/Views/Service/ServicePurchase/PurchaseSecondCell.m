//
//  PurchaseSecondCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "PurchaseSecondCell.h"

@interface PurchaseSecondCell ()

@property (nonatomic, strong) UIImageView       *titleImg;
@property (nonatomic, strong) UILabel           *titleLbl;
@property (nonatomic, strong) UILabel           *priceLbl;
@property (nonatomic, strong) UILabel           *desLbl1;
@property (nonatomic, strong) UILabel           *desLbl2;
@property (nonatomic, strong) UILabel           *desLbl3;
@property (nonatomic, strong) UILabel           *lineLbl1;
@property (nonatomic, strong) UILabel           *lineLbl2;
@property (nonatomic, strong) UILabel           *lineLbl3;
@property (nonatomic, strong) UILabel           *countLbl;
@property (nonatomic, strong) UIButton          *minBtn;
@property (nonatomic, strong) UIButton          *plsBtn;
@property (nonatomic, strong) UITextView        *commentView;

@end

@implementation PurchaseSecondCell

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
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        _titleImg.image = [UIImage imageNamed:@"product_placeholder"];
        
        [self.contentView addSubview:_titleImg];
    }
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, kScreenWidth - 130, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:13.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"财务软件记账宝正版代理记账软件";
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(120, 50, kScreenWidth - 130, 30)];
        _priceLbl.textColor = [UIColor redColor];
        _priceLbl.font = [UIFont systemFontOfSize:15.0f];
        _priceLbl.text = @"￥260.00";
        
        [self.contentView addSubview:_priceLbl];
    }
    
    if (!_lineLbl1) {
        _lineLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, kScreenWidth - 20, 0.5)];
        _lineLbl1.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_lineLbl1];
    }
    
    if (!_desLbl1) {
        _desLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 120, 20)];
        _desLbl1.font = [UIFont systemFontOfSize:13.0f];
        _desLbl1.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_desLbl1];
    }
    
    if (!_minBtn) {
        _minBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _minBtn.frame = CGRectMake(kScreenWidth - 100, 130, 30, 20);
        
        [self.contentView addSubview:_minBtn];
    }
    
    if (!_countLbl) {
        _countLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 130, 30, 20)];
        _countLbl.textColor = [UIColor blackColor];
        _countLbl.font = [UIFont systemFontOfSize:13.0f];
        _countLbl.text = @"1";
        
        [self.contentView addSubview:_countLbl];
    }
}

@end