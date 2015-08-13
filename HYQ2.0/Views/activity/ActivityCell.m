//
//  activityCell.m
//  HYQ
//
//  Created by 周翔 on 15/6/25.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "ActivityCell.h"

@interface ActivityCell ()

@property (nonatomic, retain) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *desLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UIImageView *imgPicture;

@end

@implementation ActivityCell

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
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 130, 30)];
        _titleLbl.textColor = USERNAME_COLOR;
        _titleLbl.font = [UIFont systemFontOfSize:15.0f];
        _titleLbl.text = @"标题要长标题要长标题要长标题要长标题要长标题要长";
        [self.contentView addSubview:self.titleLbl];
    }

    if (!_imgPicture) {
        _imgPicture = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 125, 5, 120, 80)];
        _imgPicture.backgroundColor = ORANGE_COLOR;
        [self.contentView addSubview:_imgPicture];
    }
    
    if (!_desLbl) {
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 65, kScreenWidth - 125, 15)];
        _desLbl.font = [UIFont systemFontOfSize:11.0f];
        _desLbl.textColor = [UIColor grayColor];
        _desLbl.text = @"发布者|2015.8.12";
        [self.contentView addSubview:_desLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, kScreenWidth, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:_lineLbl];
    }
}


@end
