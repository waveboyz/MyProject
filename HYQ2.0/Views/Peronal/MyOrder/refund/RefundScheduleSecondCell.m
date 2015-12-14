//
//  RefundScheduleSecondCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/28.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "RefundScheduleSecondCell.h"
#import "GlobalConst.h"
#import "SubOrderModel.h"

@interface RefundScheduleSecondCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UILabel *desLbl;

@end

@implementation RefundScheduleSecondCell

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
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 150, 20)];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.text = @"退款子订单";
    }
    [self.contentView addSubview:_titleLbl];
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, kScreenWidth - 30, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
    }
    [self.contentView addSubview:_lineLbl];
    
    if (!_desLbl) {
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 65, 15, 50, 20)];
        _desLbl.font = [UIFont systemFontOfSize:13.0f];
        _desLbl.textColor = NAVIBAR_GREEN_COLOR;
        _desLbl.text = @"退款中";
    }
    [self.contentView addSubview:_desLbl];
}

- (void)setSubArr:(NSArray *)subArr
{
    _subArr = subArr;
    
    for (UIView *sub in [self.contentView subviews]) {
        if ([sub isKindOfClass:[UILabel class]] || [sub isKindOfClass:[UILabel class]]) {
            [sub removeFromSuperview];
        }
    }
    [self setViews];
    
    if (_subArr.count) {
        for (int i = 0; i<_subArr.count; i ++) {
            SubOrderModel *model = _subArr[i];
            UILabel *deslbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 65 + i * 25, kScreenWidth * 0.5 + 30, 20)];
            deslbl.font = [UIFont systemFontOfSize:13.0f];
            NSString *month  = [model.month stringValue];
            NSString *orderNum = [model.subOrderNum stringValue];
            deslbl.text = [NSString stringWithFormat:@"第%@月   编码：%@",month,orderNum];
            deslbl.textColor = [UIColor grayColor];
            [self.contentView addSubview:deslbl];
        }
    }
}

@end