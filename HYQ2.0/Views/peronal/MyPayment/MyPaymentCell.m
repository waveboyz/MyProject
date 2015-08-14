//
//  MyPaymentCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/13.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyPaymentCell.h"

@interface MyPaymentCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *dateLbl;
@property (nonatomic, strong) UILabel *priceLbl;
@property (nonatomic, strong) UILabel *lineLbl;

@end

@implementation MyPaymentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }

    return self;
}

- (void)setViews
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth * 0.5 - 40, 20)];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"这是一个标题要长要长要长";
        _titleLbl.font = [UIFont systemFontOfSize:15.0f];
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_dateLbl) {
        _dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, kScreenWidth * 0.5 - 40 , 15)];
        _dateLbl.textColor = [UIColor grayColor];
        _dateLbl.font = [UIFont systemFontOfSize:13.0f];
        _dateLbl.text = @"2105/08/25  09:00:00";
        [self.contentView addSubview:_dateLbl];
    }
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 130, 10, 120, 20)];
        _priceLbl.font = [UIFont systemFontOfSize:15.0f];
        _priceLbl.textColor = [UIColor redColor];
        _priceLbl.text = @"+1.00";
        _priceLbl.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_priceLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, kScreenWidth - 10, 0.5)];
        _lineLbl.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_lineLbl];
    }
}

@end