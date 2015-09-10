//
//  ServiceDetailSecondCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceDetailSecondCell.h"
#import "CWStarRateView.h"

@interface ServiceDetailSecondCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UILabel *desLbl1;
@property (nonatomic, strong) UILabel *desLbl2;
@property (nonatomic, strong) UILabel *desLbl3;
@property (nonatomic, strong) UILabel *desLbl4;
@property (nonatomic, strong) CWStarRateView *starview1;
@property (nonatomic, strong) CWStarRateView *starview2;
@property (nonatomic, strong) CWStarRateView *starview3;
@property (nonatomic, strong) CWStarRateView *starview4;

@end

@implementation ServiceDetailSecondCell

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
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 10, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:15.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"服务质量";
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, kScreenWidth - 20, 0.5)];
        _lineLbl.backgroundColor = GRAY_COLOR;
        
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_desLbl1) {
        _desLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 50.5, 55, 20)];
        _desLbl1.font = [UIFont systemFontOfSize:13.0f];
        _desLbl1.textColor = [UIColor blackColor];
        _desLbl1.text = @"服务态度";
        
        [self.contentView addSubview:_desLbl1];
    }
    
    if (!_starview1) {
        _starview1 = [[CWStarRateView alloc] initWithFrame:CGRectMake(65, 50.5, kScreenWidth * 0.5 - 75, 20) numberOfStars:5];
        
        [self.contentView addSubview:_starview1];
    }
    
    if (!_desLbl2) {
        _desLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5, 50.5, 55, 20)];
        _desLbl2.font = [UIFont systemFontOfSize:13.0f];
        _desLbl2.textColor = [UIColor blackColor];
        _desLbl2.text = @"服务态度";
        
        [self.contentView addSubview:_desLbl2];
    }
    
    if (!_starview2) {
        _starview2 = [[CWStarRateView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + 55, 50.5, kScreenWidth * 0.5 - 75, 20) numberOfStars:5];
        
        [self.contentView addSubview:_starview2];
    }
    
    if (!_desLbl3) {
        _desLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 80.5, 55, 20)];
        _desLbl3.font = [UIFont systemFontOfSize:13.0f];
        _desLbl3.textColor = [UIColor blackColor];
        _desLbl3.text = @"服务态度";
        
        [self.contentView addSubview:_desLbl3];
    }
    
    if (!_starview3) {
        _starview3 = [[CWStarRateView alloc] initWithFrame:CGRectMake(65, 80.5, kScreenWidth * 0.5 - 75, 20) numberOfStars:5];
        
        [self.contentView addSubview:_starview3];
    }
    
    if (!_desLbl4) {
        _desLbl4 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5, 80.5, 55, 20)];
        _desLbl4.font = [UIFont systemFontOfSize:13.0f];
        _desLbl4.textColor = [UIColor blackColor];
        _desLbl4.text = @"服务态度";
        
        [self.contentView addSubview:_desLbl4];
    }
    
    if (!_starview4) {
        _starview4 = [[CWStarRateView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + 55, 80.5, kScreenWidth * 0.5 - 75, 20) numberOfStars:5];
        
        [self.contentView addSubview:_starview4];
    }
}

@end