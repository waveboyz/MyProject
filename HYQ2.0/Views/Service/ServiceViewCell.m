//
//  ServiceViewCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceViewCell.h"

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
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 120, 120)];
        _imageview.image = [UIImage imageNamed:@"product_placeholder"];
        [self.contentView addSubview:_imageview];
    }
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, kScreenWidth - 135, 20)];
        _titleLbl.text = @"这是一条标题";
        _titleLbl.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(130, 35, kScreenWidth - 135, 25)];
        _priceLbl.text = @"￥100";
        _priceLbl.textColor = [UIColor redColor];
        _priceLbl.font = [UIFont systemFontOfSize:17.0f];
        [self.contentView addSubview:_priceLbl];
    }
    
    if (!_collectView) {
        _collectView = [[UIImageView alloc] initWithFrame:CGRectMake(130, 105, 15, 15)];
        _collectView.image = [UIImage imageNamed:@"heart_collect"];
        [self.contentView addSubview:_collectView];
    }
    
    if (!_collectCntLbl) {
        _collectCntLbl = [[UILabel alloc] initWithFrame:CGRectMake(150, 105, (kScreenWidth - 155)*0.5, 15)];
        _collectCntLbl.text = @"10人收藏";
        _collectCntLbl.textColor = [UIColor grayColor];
        _collectCntLbl.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_collectCntLbl];
    }
    
    if (!_purchaseCntLbl) {
        _purchaseCntLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + 77.5, 105, (kScreenWidth - 155)*0.5, 15)];
        _purchaseCntLbl.text = @"2人购买";
        _purchaseCntLbl.textColor = [UIColor grayColor];
        _purchaseCntLbl.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_purchaseCntLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 130, kScreenWidth - 10, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:_lineLbl];
    }
}

@end
