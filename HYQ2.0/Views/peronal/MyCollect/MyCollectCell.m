//
//  MyCollectCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/13.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyCollectCell.h"

@interface MyCollectCell ()

@property (nonatomic, strong) UIImageView *imgPic;
@property (nonatomic, strong) UILabel     *titleLbl;
@property (nonatomic, strong) UILabel     *priceLlbl;
@property (nonatomic, strong) UILabel     *lineLbl;

@end

@implementation MyCollectCell

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
    if (!_imgPic) {
        _imgPic = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 80, 80)];
        _imgPic.backgroundColor = ORANGE_COLOR;
        
        [self.contentView addSubview:_imgPic];
    }
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, kScreenWidth - 95, 15)];
        _titleLbl.textColor = [UIColor grayColor];
        _titleLbl.font = [UIFont systemFontOfSize:13.0f];
        _titleLbl.text = @"这是一个标题所以要长这是一个标题所以要长这是一个标题所以要长";
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_priceLlbl) {
        _priceLlbl = [[UILabel alloc] initWithFrame:CGRectMake(90, 70, kScreenWidth - 95, 15)];
        _priceLlbl.font = [UIFont systemFontOfSize:13.0f];
        _priceLlbl.textColor = [UIColor redColor];
        _priceLlbl.text = @"￥260.00";
        
        [self.contentView addSubview:_priceLlbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(90, 90, kScreenWidth - 90, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:_lineLbl];
    }
}

@end