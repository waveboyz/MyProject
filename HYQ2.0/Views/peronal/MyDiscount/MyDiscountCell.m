//
//  MyDiscountCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/13.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyDiscountCell.h"

@interface MyDiscountCell ()

@property (nonatomic, strong) UIImageView   *imgPic;

@end

@implementation MyDiscountCell

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
    if (!_imgPic) {
        _imgPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth -20, 100)];
        _imgPic.image = [UIImage imageNamed:@"enable_ticket"];
        
        [self.contentView addSubview:_imgPic];
    }
}

@end