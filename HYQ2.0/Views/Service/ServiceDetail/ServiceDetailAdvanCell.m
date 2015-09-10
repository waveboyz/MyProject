//
//  ServiceDetailAdvanCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/8/27.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceDetailAdvanCell.h"

@interface ServiceDetailAdvanCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UIImageView *img1;
@property (nonatomic, strong) UIImageView *img2;
@property (nonatomic, strong) UIImageView *img3;

@end

@implementation ServiceDetailAdvanCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
    }
    
    return self;
}

- (void)setViews
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 10, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:15.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"我们的优势";
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, kScreenWidth - 20, 0.5)];
        _lineLbl.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_img1) {
        _img1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, kScreenWidth - 20, 120)];
        _img1.image = [UIImage imageNamed:@""];
        
        [self.contentView addSubview:_img1];
    }
    
    if (!_img2) {
        _img2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 170, kScreenWidth - 20, 120)];
        _img2.image = [UIImage imageNamed:@""];
        
        [self.contentView addSubview:_img2];
    }
    
    if (!_img3) {
        _img3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 290, kScreenWidth - 20, 120)];
        _img3.image = [UIImage imageNamed:@""];
        
        [self.contentView addSubview:_img3];
    }

}

@end