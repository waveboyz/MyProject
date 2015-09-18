//
//  PurchaseHeaderCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "PurchaseHeaderCell.h"

@interface PurchaseHeaderCell ()

@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *phoneLbl;
@property (nonatomic, strong) UILabel *addLbl;
@property (nonatomic, strong) UILabel *lineLbl;

@end

@implementation PurchaseHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
    }

    return self;
}

- (void)setViews
{
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 120, 20)];
        _nameLbl.font = [UIFont systemFontOfSize:15.0f];
        _nameLbl.textColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLbl];
    }
    
    if (!_phoneLbl) {
        _phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 180, 10, 120, 20)];
        _phoneLbl.textColor = [UIColor blackColor];
        _phoneLbl.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_phoneLbl];
    }
    
    if (!_addLbl) {
        _addLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, kScreenWidth - 30, 40)];
        _addLbl.font = [UIFont systemFontOfSize:15.0f];
        _addLbl.textColor = [UIColor blackColor];
        [self.contentView addSubview:_addLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, kScreenWidth, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLbl];
    }
}

- (void)setAddress:(AddressModel *)address
{
    _address = address;
    
    if (![_address.linkman isEqualToString:@""]) {
        _nameLbl.text = _address.linkman;
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:_nameLbl.text];
        NSRange range = NSMakeRange(0, attStr.length);
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:range];
        CGRect rect = [attStr boundingRectWithSize:CGSizeMake(120, 20) options:NSStringDrawingUsesFontLeading context:nil];
        _nameLbl.frame = CGRectMake(10, 10, rect.size.width, 20);
    }

    if (_address.linkPhone != nil) {
        _phoneLbl.text = [_address.linkPhone stringValue];
        NSMutableAttributedString *phoneAtt = [[NSMutableAttributedString alloc] initWithString:_phoneLbl.text];
        NSRange phoneRange = NSMakeRange(0, phoneAtt.length);
        [phoneAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:phoneRange];
        CGRect phoneRect = [phoneAtt boundingRectWithSize:CGSizeMake(120, 20) options:NSStringDrawingUsesFontLeading context:nil];
        _phoneLbl.frame = CGRectMake(kScreenWidth - phoneRect.size.width - 40, 10, phoneRect.size.width, 20);
    }
    
    if (_address.province && _address.city && _address.district &&_address.address) {
            _addLbl.text = [NSString stringWithFormat:@"%@  %@  %@  %@",_address.province,_address.city,_address.district,_address.address];
    }
}

@end