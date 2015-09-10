//
//  MyDiscountCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/13.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyDiscountCell.h"

@interface MyDiscountCell ()

@property (nonatomic, strong) UIImageView   *imgPic;
@property (nonatomic, strong) UILabel *priceLbl;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *timeLbl;

@end

@implementation MyDiscountCell

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
    if (!_imgPic) {
        _imgPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth -20, 100)];
        _imgPic.image = [UIImage imageNamed:@"enable_ticket"];
        
        [self.contentView addSubview:_imgPic];
    }
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 80)];
        _priceLbl.textColor = [UIColor redColor];
        _priceLbl.font = [UIFont systemFontOfSize:43.0];
        
        [_imgPic addSubview:_priceLbl];
    }
    
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, kScreenWidth - 190, 20)];
        _nameLbl.font = [UIFont systemFontOfSize:15.0f];
        _nameLbl.textColor = [UIColor blackColor];
        
        [_imgPic addSubview:_nameLbl];
    }
    
    if (!_timeLbl) {
        _timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(120, 70, kScreenWidth - 190, 20)];
        _timeLbl.font = [UIFont systemFontOfSize:13.0f];
        _timeLbl.textColor = [UIColor grayColor];
        
        [_imgPic addSubview:_timeLbl];
    }
}

- (void)setDiscount:(DiscountModel *)discount
{
    _discount = discount;
    //--------------------
    _priceLbl.text = [discount.money stringValue];
    //--------------------
    _nameLbl.text = _discount.name;
    //--------------------
    _timeLbl.text = [NSString stringWithFormat:@"期限：%@至%@",_discount.startTime,_discount.lastTime];
}

@end