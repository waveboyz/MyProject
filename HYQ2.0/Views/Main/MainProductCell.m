//
//  MainProductCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/26.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MainProductCell.h"
#import "GlobalConst.h"
#import "UIImageView+WebCache.h"

@interface MainProductCell ()

@property (nonatomic, strong) UIImageView *productImg;

@end

@implementation MainProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = GRAY_COLOR;
    }
    
    return self;
}

- (void)setViews
{
    if (!_productImg) {
        _productImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 235)];
        [self.contentView addSubview:_productImg];
    }
}

@end