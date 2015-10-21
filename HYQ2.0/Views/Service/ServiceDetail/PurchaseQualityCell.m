//
//  PurchaseQualityCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/19.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "PurchaseQualityCell.h"
#import "CWStarRateView.h"
#import "GlobalConst.h"
#import "EvaluateModel.h"

@interface PurchaseQualityCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *desLbl1;
@property (nonatomic, strong) UILabel *desLbl2;
@property (nonatomic, strong) UILabel *desLbl3;
@property (nonatomic, strong) UILabel *desLbl4;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) CWStarRateView    *rateView1;
@property (nonatomic, strong) CWStarRateView    *rateView2;
@property (nonatomic, strong) CWStarRateView    *rateView3;
@property (nonatomic, strong) CWStarRateView    *rateView4;

@end

@implementation PurchaseQualityCell

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
    CGFloat width = (kScreenWidth * 0.5 - 30) / 2;
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth * 0.5, 30)];
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"服务质量";
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, kScreenWidth - 30, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_desLbl1) {
        _desLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, width, 20)];
        _desLbl1.font = [UIFont systemFontOfSize:11.0f];
        _desLbl1.textColor = [UIColor blackColor];
        _desLbl1.text = @"整体满意度";
        [self.contentView addSubview:_desLbl1];
    }
    
    if (!_desLbl2) {
        _desLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5, 70, width, 20)];
        _desLbl2.font = [UIFont systemFontOfSize:11.0f];
        _desLbl2.textColor = [UIColor blackColor];
        _desLbl2.text = @"反应速度";
        [self.contentView addSubview:_desLbl2];
    }
    
    if (!_desLbl3) {
        _desLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, width, 20)];
        _desLbl3.font = [UIFont systemFontOfSize:11.0f];
        _desLbl3.textColor = [UIColor blackColor];
        _desLbl3.text = @"反应态度";
        [self.contentView addSubview:_desLbl3];
    }
    
    if (!_desLbl4) {
        _desLbl4 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5, 100, width, 20)];
        _desLbl4.font = [UIFont systemFontOfSize:11.0f];
        _desLbl4.textColor = [UIColor blackColor];
        _desLbl4.text = @"性 价 比";
        [self.contentView addSubview:_desLbl4];
    }
    
    if (!_rateView1) {
        _rateView1 = [[CWStarRateView alloc] initWithFrame:CGRectMake(15+ width, 70, width, 20) numberOfStars:5];
        _rateView1.userInteractionEnabled = NO;
        [self.contentView addSubview:_rateView1];
    }
    
    if (!_rateView2) {
        _rateView2 = [[CWStarRateView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + width, 70, width, 20) numberOfStars:5];
        _rateView2.userInteractionEnabled = NO;
        [self.contentView addSubview:_rateView2];
    }
    
    if (!_rateView3) {
        _rateView3 = [[CWStarRateView alloc] initWithFrame:CGRectMake(15+ width, 100, width, 20) numberOfStars:5];
        _rateView3.userInteractionEnabled = NO;
        [self.contentView addSubview:_rateView3];
    }
    
    if (!_rateView4) {
        _rateView4 = [[CWStarRateView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + width, 100, width, 20) numberOfStars:5];
        _rateView4.userInteractionEnabled = NO;
        [self.contentView addSubview:_rateView4];
    }
}

- (void)setEvaluate:(EvaluateModel *)evaluate
{
    _evaluate = evaluate;
    if (![_evaluate.level0 isEqual:[NSNull null]]) {
        _rateView1.scorePercent = [_evaluate.level0 floatValue];
    }
    
    if (![_evaluate.level1 isEqual:[NSNull null]]) {
        _rateView2.scorePercent = [_evaluate.level1 floatValue];
    }
    
    if (![_evaluate.level2 isEqual:[NSNull null]]) {
        _rateView3.scorePercent = [_evaluate.level2 floatValue];
    }
    
    if (![_evaluate.level3 isEqual:[NSNull null]]) {
        _rateView4.scorePercent = [_evaluate.level3 floatValue];
    }
}
@end
