//
//  MyAddressCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/13.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyAddressCell.h"

@interface MyAddressCell ()

@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *phoneLbl;
@property (nonatomic, strong) UILabel *addressLbl;
@property (nonatomic, strong) UILabel *lineLbl;

@end
@implementation MyAddressCell

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
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 15)];
        _nameLbl.font = [UIFont systemFontOfSize:15.0f];
        _nameLbl.text = @"习大大";
        
        [self.contentView addSubview:_nameLbl];
    }
    
    if (!_phoneLbl) {
        _phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 150, 10, 120, 15)];
        _phoneLbl.font = [UIFont systemFontOfSize:15.0f];
        _phoneLbl.text = @"15558170028";
        
        [self.contentView addSubview:_phoneLbl];
    }
    
    if (!_addressLbl) {
        _addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, kScreenWidth - 60, 40)];
        _addressLbl.font = [UIFont systemFontOfSize:13.0f];
        _addressLbl.textColor = [UIColor grayColor];
        _addressLbl.text = @"浙江省 杭州市 西湖区 翠园街道黄姑山路20号颐高创业大厦1210";
        _addressLbl.numberOfLines = 2;
        [self.contentView addSubview:_addressLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, 0.5)];
        _lineLbl.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_lineLbl];
    }
}

@end