//
//  ExcellentForthCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/5.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentForthCell.h"

@interface ExcellentForthCell ()

@property (nonatomic, strong)UILabel *titleLbl;
@property (nonatomic, strong)UILabel *lineLbl;
@property (nonatomic, strong)UILabel *desLbl;
@property (nonatomic, strong)UIImageView *contentImg;

@end

@implementation ExcellentForthCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 20, 30)];
        _titleLbl.text = @"详细介绍";
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blueColor];
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, kScreenWidth - 20, 0.5)];
        _lineLbl.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_desLbl) {
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, kScreenWidth - 20, 90)];
        
        _desLbl.text = @"填写《优创基地入驻申请表》，优创事业部进行审核，通过审核签署《优创基地入驻协议》。投行部进行审核，符合条件的项目可以免租、优创基地事业部进行审核，通过审核签署《优创基地入驻协议》，投行部进行审核，符合条件的项目可以免租。";
        _desLbl.font = [UIFont systemFontOfSize:14.0f];
        _desLbl.textColor = [UIColor grayColor];
        _desLbl.numberOfLines = 5;
        
        [self.contentView addSubview:_desLbl];
    }
    
    if (!_contentImg) {
        _contentImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 145, kScreenWidth - 20, 120)];
        _contentImg.image = [UIImage imageNamed:@"codeGetIcon"];
        _contentImg.contentMode = UIViewContentModeScaleToFill;
        
        [self.contentView addSubview:_contentImg];
    }
}

@end
