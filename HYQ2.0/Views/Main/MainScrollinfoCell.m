//
//  MainScrollinfoCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/20.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MainScrollinfoCell.h"

@interface MainScrollinfoCell ()

@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UILabel     *lineLbl;

@end

@implementation MainScrollinfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setViews
{
    CGFloat IconWidth = (kScreenWidth - 160) / 4;
    
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, IconWidth + 20, 20)];
        _titleImg.image = [UIImage imageNamed:@"info_scroll"];
        
        [self.contentView addSubview:_titleImg];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(IconWidth + 35, 10, 0.5, 20)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:_lineLbl];
    }
}

@end