//
//  ServiceViewCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceViewCell.h"
#import "UIImageView+WebCache.h"
#import "HYQInterfaceMethod.h"

@interface ServiceViewCell ()

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel     *titleLbl;
@property (nonatomic, strong) UILabel     *priceLbl;
@property (nonatomic, strong) UIImageView *collectView;
@property (nonatomic, strong) UILabel     *collectCntLbl;
@property (nonatomic, strong) UILabel     *purchaseCntLbl;
@property (nonatomic, strong) UILabel     *lineLbl;

@end

@implementation ServiceViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setViews];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    return self;
}

- (void)setViews;
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 100, 100)];
        _imageview.image = [UIImage imageNamed:@"product_placeholder"];
        [self.contentView addSubview:_imageview];
    }
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(130, 15, kScreenWidth - 135, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(130, 52.5, kScreenWidth - 135, 25)];
        _priceLbl.textColor = [UIColor redColor];
        _priceLbl.font = [UIFont systemFontOfSize:17.0f];
        [self.contentView addSubview:_priceLbl];
    }
    
    if (!_collectView) {
        _collectView = [[UIImageView alloc] initWithFrame:CGRectMake(130, 95, 15, 15)];
        _collectView.image = [UIImage imageNamed:@"heart_collect"];
        [self.contentView addSubview:_collectView];
    }
    
    if (!_collectCntLbl) {
        _collectCntLbl = [[UILabel alloc] initWithFrame:CGRectMake(150, 95, (kScreenWidth - 155)*0.5, 15)];
        _collectCntLbl.textColor = [UIColor grayColor];
        _collectCntLbl.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_collectCntLbl];
    }
    
    if (!_purchaseCntLbl) {
        _purchaseCntLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + 77.5, 95, (kScreenWidth - 155)*0.5, 15)];
        _purchaseCntLbl.textColor = [UIColor grayColor];
        _purchaseCntLbl.font = [UIFont systemFontOfSize:13.0f];
        _purchaseCntLbl.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_purchaseCntLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 130, kScreenWidth - 10, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:_lineLbl];
    }
}

- (void)setService:(ServiceModel *)service
{
    _service = service;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",LOCAL_HOST,_service.photo];
    [_imageview sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"product_placeholder"]];
    //------------------------------------
    _collectCntLbl.text = [_service.colCount stringValue];
    //------------------------------------
    _purchaseCntLbl.text =[NSString stringWithFormat:@"%@人购买",[_service.payCount stringValue]];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:_purchaseCntLbl.text];
    NSRange range = NSMakeRange(0, attStr.length);
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:range];
    CGRect rect = [attStr boundingRectWithSize:CGSizeMake(kScreenWidth*0.5, 15) options:NSStringDrawingUsesFontLeading context:nil];
    _purchaseCntLbl.frame = CGRectMake(kScreenWidth - rect.size.width - 10, 95, rect.size.width, 15);
    //------------------------------------
    _priceLbl.text = [NSString stringWithFormat:@"￥%@",[_service.price stringValue]];
    //------------------------------------
    _titleLbl.text = _service.title;
}

@end