//
//  ServiceDetailThirdCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceDetailThirdCell.h"

@interface ServiceDetailThirdCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;

@end

@implementation ServiceDetailThirdCell

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
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 10, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:15.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"产品详情";
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, kScreenWidth - 20, 0.5)];
        _lineLbl.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_lineLbl];
    }
}

@end