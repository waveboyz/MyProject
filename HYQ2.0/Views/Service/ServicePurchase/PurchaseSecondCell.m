//
//  PurchaseSecondCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "PurchaseSecondCell.h"
#import "UIImageView+WebCache.h"
#import "ProductTypeModel.h"
#import "ProductComboModel.h"

@interface PurchaseSecondCell ()

@property (nonatomic, strong) UIImageView       *titleImg;  //产品图
@property (nonatomic, strong) UILabel           *titleLbl;  //产品标题
@property (nonatomic, strong) UILabel           *priceLbl;  //价格标签
@property (nonatomic, strong) UILabel           *desLbl1;   //购买数量
@property (nonatomic, strong) UILabel           *typeLbl;    //购买的子产品
@property (nonatomic, strong) UILabel           *comboLbl;  //购买的套餐
@property (nonatomic, strong) UILabel           *desLbl2;
@property (nonatomic, strong) UILabel           *desLbl3;   //留言备注
@property (nonatomic, strong) UILabel           *lineLbl1;
@property (nonatomic, strong) UILabel           *lineLbl2;
@property (nonatomic, strong) UILabel           *lineLbl3;
@property (nonatomic, strong) UILabel           *countLbl;  //显示数量
@property (nonatomic, strong) UIButton          *minBtn;    //减
@property (nonatomic, strong) UIButton          *plsBtn;    //加

@end

@implementation PurchaseSecondCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        _comboArr = [NSArray new];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setViews
{
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        [self.contentView addSubview:_titleImg];
    }
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, kScreenWidth - 130, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:15.0f];
        _titleLbl.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_typeLbl) {
        _typeLbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 35, kScreenWidth - 130, 15)];
        _typeLbl.font = [UIFont systemFontOfSize:13.0f];
        _typeLbl.textColor = [UIColor grayColor];
        [self.contentView addSubview:_typeLbl];
    }
    
    if (!_comboLbl) {
        _comboLbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, kScreenWidth - 130, 15)];
        _comboLbl.font = [UIFont systemFontOfSize:13.0f];
        _comboLbl.textColor = [UIColor grayColor];
        [self.contentView addSubview:_comboLbl];
    }
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, kScreenWidth - 130, 20)];
        _priceLbl.textColor = [UIColor redColor];
        _priceLbl.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_priceLbl];
    }
    
    if (!_lineLbl1) {
        _lineLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, kScreenWidth - 20, 0.5)];
        _lineLbl1.backgroundColor = GRAY_COLOR;
        [self.contentView addSubview:_lineLbl1];
    }
    
    if (!_desLbl1) {
        _desLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 120, 20)];
        _desLbl1.font = [UIFont systemFontOfSize:15.0f];
        _desLbl1.textColor = [UIColor blackColor];
        _desLbl1.text = @"购买数量";
        [self.contentView addSubview:_desLbl1];
    }
    
    if (!_minBtn) {
        _minBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _minBtn.frame = CGRectMake(kScreenWidth - 110, 130, 30, 20);
        [_minBtn setTitle:@"-" forState:UIControlStateNormal];
        [_minBtn setBackgroundColor:[UIColor grayColor]];
        [_minBtn addTarget:self action:@selector(minBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_minBtn];
    }
    
    if (!_countLbl) {
        _countLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 130, 40, 20)];
        _countLbl.textColor = [UIColor blackColor];
        _countLbl.textAlignment = NSTextAlignmentCenter;
        _countLbl.font = [UIFont systemFontOfSize:13.0f];
        _serviceCnt = 1;
        _countLbl.text = [NSString stringWithFormat:@"%ld",_serviceCnt];
        [self.contentView addSubview:_countLbl];
    }
    
    if (!_plsBtn) {
        _plsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _plsBtn.frame = CGRectMake(kScreenWidth - 40, 130, 30, 20);
        [_plsBtn setTitle:@"+" forState:UIControlStateNormal];
        [_plsBtn setBackgroundColor:[UIColor grayColor]];
        [_plsBtn addTarget:self action:@selector(plsBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_plsBtn];
    }
    
    if (!_lineLbl2) {
        _lineLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, kScreenWidth - 20, 0.5)];
        _lineLbl2.backgroundColor = BG_GRAY_COLOR;
        [self.contentView addSubview:_lineLbl2];
    }
//    
//    if (!_desLbl2) {
//        _desLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 190, kScreenWidth * 0.5, 20)];
//        _desLbl2.font = [UIFont systemFontOfSize:15.0f];
//        _desLbl2.textColor = [UIColor blackColor];
//        _desLbl2.text = @"使用积分券";
//        [self.contentView addSubview:_desLbl2];
//    }
//    
//    if (!_lineLbl3) {
//        _lineLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, kScreenWidth - 20, 0.5)];
//        _lineLbl3.backgroundColor = BG_GRAY_COLOR;
//        [self.contentView addSubview:_lineLbl3];
//    }
    
    if (!_desLbl3) {
        _desLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 190, 120, 20)];
        _desLbl3.font = [UIFont systemFontOfSize:15.0f];
        _desLbl3.textColor = [UIColor blackColor];
        _desLbl3.text = @"我要留言备注";
        [self.contentView addSubview:_desLbl3];
    }
    
    if (!_commentView) {
        _commentView = [[UITextView alloc] initWithFrame:CGRectMake(0, 220, kScreenWidth, 80)];
        _commentView.font = [UIFont systemFontOfSize:15.0f];
        _commentView.textColor = [UIColor blackColor];
        _commentView.delegate = self;
        _commentView.text = @" 我对卖家有话说";
        [self.contentView addSubview:_commentView];
    }
}

- (void)setProduct:(ProductModel *)product
{
    _product = product;
    if (_product.name) {
        _titleLbl.text = _product.name;
    }
    
    if (_product.name && _product.xiangou) {
        _titleLbl.text = [NSString stringWithFormat:@"%@(限购%@份)",_product.name,[_product.xiangou stringValue]];
    }

    if (_product.photo) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",LOCAL_HOST,_product.photo];
        [_titleImg sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"product_placeholder"]];
    }
}

- (void)setType:(ProductTypeModel *)type
{
    _type = type;
    if(_type.psname) {
        _typeLbl.text = [NSString stringWithFormat:@"已选择：“%@”",_type.psname];
    }
}

- (void)setComboArr:(NSArray *)comboArr
{
    _comboArr = comboArr;
    NSMutableString *str = [NSMutableString new];
    if (_comboArr.count) {
        for (ProductComboModel *model in _comboArr) {
            [str appendFormat:@"“%@”",model.pdname];
        }
    }
    
    _comboLbl.text = [NSString stringWithFormat:@"已选择：%@",str];
}

//------------------------------------
- (void)setPrice:(NSInteger)price
{
    _price = price;
    
    if (_price) {
        _priceLbl.text = [NSString stringWithFormat:@"￥%ld",_price];
    }
}

- (void)plsBtnPressed
{
    if (_product.xiangou) {
        if (_serviceCnt < [_product.xiangou integerValue]) {
            _serviceCnt += 1;
        }
    }else{
    _serviceCnt +=1;
    }
    
    _countLbl.text = [NSString stringWithFormat:@"%ld",_serviceCnt];
    [self calculatorBtnPressed];
}

- (void)minBtnPressed
{
    if (_serviceCnt > 1) {
        _serviceCnt -= 1;
    }
    _countLbl.text = [NSString stringWithFormat:@"%ld",_serviceCnt];
    [self calculatorBtnPressed];
}

- (void)calculatorBtnPressed
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(mathBtnPressedWithCount:)])
    {
        [self.delegate mathBtnPressedWithCount:_serviceCnt];
    }
}

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _commentView.text = @"";
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(elevatorScreen)]) {
        [self.delegate elevatorScreen];
    }
}

@end