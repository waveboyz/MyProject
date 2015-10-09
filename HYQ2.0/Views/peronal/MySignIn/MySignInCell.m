//
//  MySignInCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/8.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MySignInCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalConst.h"

@interface MySignInCell ()

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel     *deslbl;
@property (nonatomic, strong) UILabel     *timeLbl;
@property (nonatomic, strong) UILabel     *numlbl;
@property (nonatomic, strong) UILabel     *lineLbl;

@end

@implementation MySignInCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
    }
    
    return self;
}

- (void)setViews
{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
        [self.contentView addSubview:_iconImg];
    }

    if (!_deslbl) {
        _deslbl = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 70, 20)];
        _deslbl.font = [UIFont systemFontOfSize:13.0f];
        _deslbl.textColor = [UIColor blackColor];
        _deslbl.text = @"每日签到";
        [self.contentView addSubview:_deslbl];
    }
    
    if (!_timeLbl) {
        _timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 150, 20)];
        _timeLbl.font = [UIFont systemFontOfSize:8.0f];
        _timeLbl.textColor = GRAY_COLOR;
        [self.contentView addSubview:_timeLbl];
    }
    
    if (!_numlbl) {
        _numlbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 40, 20, 20)];
        _numlbl.font = [UIFont systemFontOfSize:10.0f];
        _numlbl.textColor  = [UIColor greenColor];
        [self.contentView addSubview:_numlbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, kScreenWidth - 40, 0.5)];
        _lineLbl.backgroundColor = LINE_COLOR;
        [self.contentView addSubview:_lineLbl];
    }
}

@end