//
//  activityCell.m
//  HYQ
//
//  Created by 周翔 on 15/6/25.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "ActivityCell.h"
#import "UIImageView+WebCache.h"

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
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    return self;
}

- (void)setViews
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 135, 50)];
        _titleLbl.textColor = USERNAME_COLOR;
        _titleLbl.font = [UIFont systemFontOfSize:15.0f];
//        _titleLbl.text = @"标题要长标题要长标题要长标题要长标题要长标题要长";
        _titleLbl.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLbl.numberOfLines = 2;
        [self.contentView addSubview:self.titleLbl];
    }

    if (!_imgPicture) {
        _imgPicture = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 125, 5, 120, 80)];
//        [_imgPicture sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"product_placeholder"]];
        [self.contentView addSubview:_imgPicture];
    }
    
    if (!_desLbl) {
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 65, kScreenWidth - 125, 15)];
        _desLbl.font = [UIFont systemFontOfSize:11.0f];
        _desLbl.textColor = [UIColor grayColor];
//        _desLbl.text = @"发布者|2015.8.12";
        [self.contentView addSubview:_desLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, kScreenWidth, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:_lineLbl];
    }
}

- (void)setActivity:(ActivityModel *)activity
{
    _titleLbl.text = activity.title;
    _desLbl.text = [NSString stringWithFormat:@"%@|null",activity.editor];
    NSString *str = [NSString stringWithFormat:@"%@%@",LOCAL_HOST,activity.photo];
    [_imgPicture sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"product_placeholder"]];
}

@end