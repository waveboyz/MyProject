//
//  ExcellentCampThirdCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/11.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentCampThirdCell.h"

@interface ExcellentCampThirdCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UILabel *desLbl1;
@property (nonatomic, strong) UILabel *desLbl2;
@property (nonatomic, strong) UILabel *desLbl3;
@property (nonatomic, strong) UIImageView *imgView1;
@property (nonatomic, strong) UIImageView *imgView2;
@property (nonatomic, strong) UIImageView *imgView3;

@end

@implementation ExcellentCampThirdCell

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
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 20, 30)];
        _titleLbl.text = @"我们的优势";
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blueColor];
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, kScreenWidth - 20, 0.5)];
        _lineLbl.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_imgView1) {
        _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 55, kScreenWidth - 20, 200)];
        _imgView1.backgroundColor = ORANGE_COLOR;
        
        [self.contentView addSubview:_imgView1];
    }
    
    if (!_desLbl1) {
        _desLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 260, kScreenWidth - 20, 15)];
        _desLbl1.text = @"融资成功是王道";
        _desLbl1.font = [UIFont systemFontOfSize:12.0f];
        _desLbl1.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_desLbl1];
    }
    
    if (!_imgView2) {
        _imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 280, kScreenWidth - 20, 200)];
        _imgView2.backgroundColor = ORANGE_COLOR;
        
        [self.contentView addSubview:_imgView2];
    }
    
    if (!_desLbl2) {
        _desLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 485, kScreenWidth - 20, 15)];
        _desLbl2.text = @"海量资源任汲取";
        _desLbl2.font = [UIFont systemFontOfSize:12.0f];
        _desLbl2.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_desLbl2];
    }
    
    if (!_imgView3) {
        _imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 505, kScreenWidth - 20, 200)];
        _imgView3.backgroundColor = ORANGE_COLOR;
        
        [self.contentView addSubview:_imgView3];
    }
    
    if (!_desLbl3) {
        _desLbl3  = [[UILabel alloc] initWithFrame:CGRectMake(10, 710, kScreenWidth - 20, 15)];
        _desLbl3.text = @"名师亲传18般创业武艺";
        _desLbl3.textColor = [UIColor grayColor];
        _desLbl3.font = [UIFont systemFontOfSize:12.0f];
        
        [self.contentView addSubview:_desLbl3];
    }
}

@end