//
//  SubOrderCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/26.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "SubOrderCell.h"
#import "GlobalConst.h"
#import "SubOrderModel.h"

@interface SubOrderCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UILabel *desLbl;

@end

@implementation SubOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
    }
    
    return self;
}

- (void)setViews
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 120, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"零申报/半年";
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, kScreenWidth - 30, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_desLbl) {
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, kScreenWidth - 30, 20)];
        _desLbl.textColor = [UIColor redColor];
        _desLbl.font = [UIFont systemFontOfSize:11.0f];
        _desLbl.text = @"小提示：已服务/服务中的内容，不予退款";
        [self.contentView addSubview:_desLbl];
    }
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    if (dataArr.count) {
        for (int i = 0; i<_dataArr.count; i++) {
            SubOrderModel *model = _dataArr[i];
            UILabel *deslbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 90 + i * 25, kScreenWidth * 0.5 + 30, 20)];
            deslbl.font = [UIFont systemFontOfSize:13.0f];
            NSString *month  = [model.month stringValue];
            NSString *orderNum = [model.subOrderNum stringValue];
            deslbl.text = [NSString stringWithFormat:@"第%@月   编码：%@",month,orderNum];
            if (model.status && model.button) {
                deslbl.textColor = [UIColor grayColor];
            }else{
                deslbl.textColor = [UIColor blackColor];
            }
            
            if ([model.status isEqualToString:@"已服务"]) {
                UILabel *stateLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 105, 90 + i * 25, 40, 20)];
                stateLbl.text = model.status;
                stateLbl.font = [UIFont systemFontOfSize:13.0f];
                stateLbl.textColor = [UIColor grayColor];
                [self.contentView addSubview:stateLbl];
            }else if ([model.status isEqualToString:@"服务中"]){
                UILabel *stateLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 105, 90 + i * 25, 40, 20)];
                stateLbl.text = model.status;
                stateLbl.font = [UIFont systemFontOfSize:13.0f];
                stateLbl.textColor = NAVIBAR_GREEN_COLOR;
                [self.contentView addSubview:stateLbl];
            }
            [self.contentView addSubview:deslbl];
        }
    }
}
@end