//
//  RefundFirstCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/27.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "RefundFirstCell.h"
#import "GlobalConst.h"
#import "SubOrderModel.h"

@interface RefundFirstCell ()
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;

@end

@implementation RefundFirstCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setViews
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 120, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"服务内容";
    }
        [self.contentView addSubview:_titleLbl];
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, kScreenWidth - 30, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
    }
        [self.contentView addSubview:_lineLbl];
}

- (void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    for (UIView *sub in [self.contentView subviews]) {
        if ([sub isKindOfClass:[UILabel class]] || [sub isKindOfClass:[UIImageView class]]) {
            [sub removeFromSuperview];
        }
    }
    
    [self setViews];
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, kScreenWidth - 30, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLbl];
    }
    
    if (_dataArr.count) {
        for (int i = 0; i < _dataArr.count; i++) {
            SubOrderModel *model = _dataArr[i];
            UILabel *desLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 60 + i * 25, kScreenWidth - 45, 20)];
            desLbl.font = [UIFont systemFontOfSize:13.0f];
            desLbl.text = [NSString stringWithFormat:@"第%@月服务内容   编码：%@",[model.month  stringValue],[model.subOrderNum stringValue]];
            [self.contentView addSubview:desLbl];
            
            UIImageView *btnImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30, 60 + i * 25, 20, 20)];
            btnImg.image = [UIImage imageNamed:@"refund_select"];
            [self.contentView addSubview:btnImg];
        }

    }
}

@end