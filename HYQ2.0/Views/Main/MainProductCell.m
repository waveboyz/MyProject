//
//  MainProductCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/26.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MainProductCell.h"
#import "GlobalConst.h"
#import "UIImageView+WebCache.h"

@interface MainProductCell ()

@property (nonatomic, strong) UIImageView *productImg;
@property (nonatomic, strong) UILabel     *desLbl;
@end

@implementation MainProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = GRAY_COLOR;
    }
    
    return self;
}

- (void)setViews
{
    if (!_productImg) {
        _productImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 235)];
        [self.contentView addSubview:_productImg];
    }
    
    if (!_desLbl) {
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, 25)];
        _desLbl.font = [UIFont systemFontOfSize:10.0f];
        _desLbl.textAlignment = NSTextAlignmentCenter;
        _desLbl.textColor = [UIColor whiteColor];
        _desLbl.backgroundColor = [UIColor colorWithRed:144/255 green:144/255 blue:144/255 alpha:0.5];
        _desLbl.text = @"仅限杭州城区";
        [self.contentView addSubview:_desLbl];
    }
}

- (void)setService:(ServiceModel *)service
{
    _service = service;
    [_productImg sd_setImageWithURL:[NSURL URLWithString:_service.logoPath] placeholderImage:[UIImage imageNamed:@"excellent_plan"]];
}

@end