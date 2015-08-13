//
//  ExcellentOpenForthCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/11.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentOpenForthCell.h"

@interface ExcellentOpenForthCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UIImageView *imgView1;
@property (nonatomic, strong) UIImageView *imgView2;

@end

@implementation ExcellentOpenForthCell

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
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 20, 30)];
        _titleLbl.text = @"优创开放日介绍";
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blueColor];
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, kScreenWidth - 20, 0.5)];
        _lineLbl.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_imgView1) {
        _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 55, kScreenWidth - 20, 100)];
        _imgView1.backgroundColor = ORANGE_COLOR;
        
        [self.contentView addSubview:_imgView1];
    }
    
    if (!_imgView2) {
        _imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 165, kScreenWidth - 20, 100)];
        _imgView2.backgroundColor = ORANGE_COLOR;
        
        [self.contentView addSubview:_imgView2];
    }
}

@end