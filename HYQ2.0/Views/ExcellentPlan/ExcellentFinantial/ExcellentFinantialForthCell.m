//
//  ExcellentFinantialForthCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/11.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentFinantialForthCell.h"

@interface ExcellentFinantialForthCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UIImageView *imgView1;
@property (nonatomic, strong) UIImageView *imgView2;
@property (nonatomic, strong) UIImageView *imgView3;
@property (nonatomic, strong) UIImageView *imgView4;

@end

@implementation ExcellentFinantialForthCell

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
        _titleLbl.text = @"服务流程";
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
        _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 55, kScreenWidth - 20, 140)];
        _imgView1.backgroundColor = ORANGE_COLOR;
        
        [self.contentView addSubview:_imgView1];
    }
    
    if (!_imgView2) {
        _imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 200, kScreenWidth - 20, 140)];
        _imgView2.backgroundColor = ORANGE_COLOR;
        
        [self.contentView addSubview:_imgView2];
    }
    
    if (!_imgView3) {
        _imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 345, kScreenWidth - 20, 140)];
        _imgView3.backgroundColor = ORANGE_COLOR;
    
        [self.contentView addSubview:_imgView3];
    }
    
    if (!_imgView4) {
        _imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 490, kScreenWidth - 20, 140)];
        _imgView4.backgroundColor = ORANGE_COLOR;
        
        [self.contentView addSubview:_imgView4];
    }
    

}
@end