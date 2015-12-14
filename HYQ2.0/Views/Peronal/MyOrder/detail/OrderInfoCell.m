//
//  OrderInfoCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/26.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "OrderInfoCell.h"
#import "GlobalConst.h"
#import "OrderInfoModel.h"

@interface OrderInfoCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UILabel *desLbl1;
@property (nonatomic, strong) UILabel *desLbl2;
@property (nonatomic, strong) UILabel *desLbl3;
@property (nonatomic, strong) UILabel *desLbl4;
@property (nonatomic, strong) UILabel *desLbl6;
@property (nonatomic, strong) UILabel *desLbl7;
@property (nonatomic, strong) UILabel *desLbl8;
@property (nonatomic, strong) UILabel *desLbl9;
@property (nonatomic, strong) UILabel *desLbl11;
@property (nonatomic, strong) UILabel *desLbl12;
@property (nonatomic, strong) UILabel *desLbl13;
@property (nonatomic, strong) UILabel *desLbl14;
@property (nonatomic, strong) UILabel *desLbl16;
@property (nonatomic, strong) UILabel *desLbl17;
@property (nonatomic, strong) UILabel *desLbl18;
@property (nonatomic, strong) UILabel *desLbl19;

@end

@implementation OrderInfoCell

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
    CGFloat width = kScreenWidth * 0.5 - 80;
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, 20)];
        _titleLbl.text = @"订单信息";
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, kScreenWidth - 30, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_desLbl1) {
        _desLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, 65, 20)];
        _desLbl1.text = @"订单编号：";
        _desLbl1.textAlignment = NSTextAlignmentRight;
        _desLbl1.textColor = [UIColor grayColor];
        _desLbl1.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl1];
    }
    
    if (!_desLbl2) {
        _desLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 85, 65, 20)];
        _desLbl2.text = @"优惠价格：";
        _desLbl2.textAlignment = NSTextAlignmentRight;
        _desLbl2.textColor = [UIColor grayColor];
        _desLbl2.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl2];
    }
    
    if (!_desLbl3) {
        _desLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 110, 65, 20)];
        _desLbl3.text = @"购买人：";
        _desLbl3.textAlignment = NSTextAlignmentRight;
        _desLbl3.textColor = [UIColor grayColor];
        _desLbl3.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl3];
    }
    
    if (!_desLbl4) {
        _desLbl4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 135, 65, 20)];
        _desLbl4.text = @"产品名称：";
        _desLbl4.textAlignment = NSTextAlignmentRight;
        _desLbl4.textColor = [UIColor grayColor];
        _desLbl4.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl4];
    }
    
    if (!_desLbl6) {
        _desLbl6 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5, 60, 65, 20)];
        _desLbl6.text = @"类型：";
        _desLbl6.textAlignment = NSTextAlignmentRight;
        _desLbl6.textColor = [UIColor grayColor];
        _desLbl6.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl6];
    }
    
    if (!_desLbl7) {
        _desLbl7 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5, 85, 65, 20)];
        _desLbl7.text = @"数量：";
        _desLbl7.textAlignment = NSTextAlignmentRight;
        _desLbl7.textColor = [UIColor grayColor];
        _desLbl7.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl7];
    }
    
    if (!_desLbl8) {
        _desLbl8 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5, 110, 65, 20)];
        _desLbl8.text = @"积分抵扣：";
        _desLbl8.textAlignment = NSTextAlignmentRight;
        _desLbl8.textColor = [UIColor grayColor];
        _desLbl8.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl8];
    }
    
    if (!_desLbl9) {
        _desLbl9 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5, 135, 65, 20)];
        _desLbl9.text = @"实付：";
        _desLbl9.textAlignment = NSTextAlignmentRight;
        _desLbl9.textColor = [UIColor grayColor];
        _desLbl9.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl9];
    }
    
    if (!_desLbl11) {
        _desLbl11 = [[UILabel alloc] initWithFrame:CGRectMake(80, 60, width, 20)];
        _desLbl11.textColor = [UIColor blackColor];
        _desLbl11.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl11];
    }
    
    if (!_desLbl12) {
        _desLbl12 = [[UILabel alloc] initWithFrame:CGRectMake(80, 85, width, 20)];
        _desLbl12.textColor = [UIColor blackColor];
        _desLbl12.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl12];
    }
    
    if (!_desLbl13) {
        _desLbl13 = [[UILabel alloc] initWithFrame:CGRectMake(80, 110, width, 20)];
        _desLbl13.textColor = [UIColor blackColor];
        _desLbl13.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl13];
    }
    
    if (!_desLbl14) {
        _desLbl14 = [[UILabel alloc] initWithFrame:CGRectMake(80, 135, width, 20)];
        _desLbl14.textColor = [UIColor blackColor];
        _desLbl14.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl14];
    }
    
    if (!_desLbl16) {
        _desLbl16 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + 80, 60, width, 20)];
        _desLbl16.textColor = [UIColor blackColor];
        _desLbl16.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl16];
    }
    
    if (!_desLbl17) {
        _desLbl17 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + 80, 85, width, 20)];
        _desLbl17.textColor = [UIColor blackColor];
        _desLbl17.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl17];
    }
    
    if (!_desLbl18) {
        _desLbl18 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + 80, 110, width, 20)];
        _desLbl18.textColor = [UIColor blackColor];
        _desLbl18.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl18];
    }
    
    if (!_desLbl19) {
        _desLbl19 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 + 80, 135, width, 20)];
        _desLbl19.textColor = [UIColor redColor];
        _desLbl19.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:_desLbl19];
    }
}

- (void)setInfo:(OrderInfoModel *)info
{
    _info = info;
    
    if (_info.oid) {
        _desLbl11.text = [NSString stringWithFormat:@"%@",[_info.oid stringValue]];
    }
    
    if (_info.oprice) {
        _desLbl12.text = [NSString stringWithFormat:@"￥%@",[_info.oprice stringValue]];
    }
    
    if (_info.olinkMan) {
        _desLbl13.text = _info.olinkMan;
    }
    
    if (_info.pname) {
        _desLbl14.text = _info.pname;
    }
    
    if (_info.otypeName) {
        _desLbl16.text = _info.otypeName;
    }
    
    if (_info.onum) {
        _desLbl17.text = [NSString stringWithFormat:@"%@",[_info.onum stringValue]];
    }
    
    if (![_info.integeral isEqual:[NSNull null]]) {
        _desLbl18.text = [NSString stringWithFormat:@"￥%@",[_info.integeral stringValue]];
    }
    
    if (![_info.money isEqual:[NSNull null]]) {
        _desLbl19.text = [NSString stringWithFormat:@"￥%@",[_info.money stringValue]];
    }
}

@end