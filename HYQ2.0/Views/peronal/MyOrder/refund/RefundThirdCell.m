//
//  RefundThirdCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/27.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "RefundThirdCell.h"
#import "GlobalConst.h"

@interface RefundThirdCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UILabel *contentLbl;

@end

@implementation RefundThirdCell

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
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"退款规则";
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, kScreenWidth - 30, 0.5)];;
        _lineLbl.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_contentLbl) {
        _contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, kScreenWidth - 30, 170)];
        _contentLbl.font = [UIFont systemFontOfSize:13.0f];
        _contentLbl.textColor = [UIColor blackColor];
        _contentLbl.numberOfLines = 20;
        _contentLbl.text = @"1.好园区尚未开始服务，未派单时，退货收取定单总金额10%的服务费，退款时间为通过审核后七天以内；\n2.好园区开始服务已派单，但服务商还没有开始服务，退货收取定单总金额10%的服务费，退款时间为通过审核后七天以内；\n3.好园区与服务商都开始服务，服务类型属于单次购买的；不能退货；\n4.好园区与服务商都开始服务，服务类型属于按时间购买的；退货费用为2个月的服务费，退款时间为通过审核后七天以内。";
        [self.contentView addSubview:_contentLbl];
    }
}

@end