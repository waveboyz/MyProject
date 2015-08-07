//
//  InfomationCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/6.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "InfomationCell.h"

@interface InfomationCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *desLbl;
@property (nonatomic, strong) UIImageView *titleview;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel   *countLbl;

@end

@implementation InfomationCell

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
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 5, 30)];
        [self.contentView addSubview:_titleLbl];
    }

    if (!_titleview) {
        _titleview = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 85, 5, 80, 80)];

        [self.contentView addSubview:_titleview];
    }
    
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 50, 10, 10)];
        
        [self.contentView addSubview:_iconView];
    }
    
    if (!_countLbl) {
        _countLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 15, 10)];
        _countLbl.textColor = NAVIBAR_GREEN_COLOR;
        _countLbl.font = [UIFont systemFontOfSize:10.0f];
        
        [self.contentView addSubview:_countLbl];
    }
    
    if (!_desLbl) {
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 120, 10)];
        _desLbl.textColor = TIME_COLOR;
        _desLbl.font = [UIFont systemFontOfSize:10.0f];
        
        [self.contentView addSubview:_desLbl];
    }
}

@end
