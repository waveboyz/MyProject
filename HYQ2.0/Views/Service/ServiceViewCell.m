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

@end

@implementation ServiceViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initViews];
    }
    
    return self;
}

- (void)initViews
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 120, 120)];
        _imageview.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:_imageview];
    }
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, kScreenWidth - 135, 20)];
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(130, 35, kScreenWidth - 135, 25)];
        [self.contentView addSubview:_priceLbl];
    }
    
    if (!_collectView) {
        _collectView = [[UIImageView alloc] initWithFrame:CGRectMake(130, 80, 20, 20)];
        [self.contentView addSubview:_collectView];
    }
    
    if (!_collectCntLbl) {
        _collectCntLbl = [[UILabel alloc] initWithFrame:CGRectMake(150, 80, (kScreenWidth - 155)*0.5, 20)];
        [self.contentView addSubview:_collectCntLbl];
    }
    
    if (!_purchaseCntLbl) {
        _purchaseCntLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + 77.5, 80, (kScreenWidth - 155)*0.5, 20)];
        [self.contentView addSubview:_purchaseCntLbl];
    }
}

@end
