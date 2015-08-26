//
//  ScrollDetailCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/25.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ScrollDetailCell.h"

@interface ScrollDetailCell ()

@property (nonatomic, strong) UILabel *titleLbl;

@end

@implementation ScrollDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setViews];
    }
    
    return self;
}

- (void)setViews
{
    CGFloat IconWidth = (kScreenWidth - 160) / 4;
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth - IconWidth - 40, 40)];
        _titleLbl.font = [UIFont systemFontOfSize:12.0f];
        _titleLbl.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_titleLbl];
    }
}

- (void)setTitleInt:(NSInteger)titleInt
{
    if (_titleLbl) {
        _titleLbl.text = [NSString stringWithFormat:@"这是滚动视图的第%ld行",titleInt];
    }
}

@end
