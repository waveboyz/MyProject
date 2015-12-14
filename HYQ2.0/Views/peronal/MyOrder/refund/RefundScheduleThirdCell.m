//
//  RefundScheduleThirdCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/28.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "RefundScheduleThirdCell.h"
#import "GlobalConst.h"
#import "RefundScheduleModel.h"

@interface RefundScheduleThirdCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UIImageView *progressImg1;    //进度图1
@property (nonatomic, strong) UIImageView *progressImg2;    //进度图2
@property (nonatomic, strong) UIImageView *progressImg3;    //进度图3
@property (nonatomic, strong) UIImageView *progressImg4;    //进度图4
@property (nonatomic, strong) UIImageView *progressImg5;    //进度图5
@property (nonatomic, strong) UIImageView *progressImg6;    //进度图6
@property (nonatomic, strong) UIImageView *progressImg7;    //进度图7
@property (nonatomic, strong) UILabel *desLbl1;             //进度描述1
@property (nonatomic, strong) UILabel *desLbl2;             //进度描述2
@property (nonatomic, strong) UILabel *desLbl3;             //进度描述3
@property (nonatomic, strong) UILabel *desLbl4;             //进度描述4
@property (nonatomic, strong) UILabel *timeLbl1;            //进度时间1
@property (nonatomic, strong) UILabel *timeLbl2;            //进度时间1
@property (nonatomic, strong) UILabel *timeLbl3;            //进度时间1
@property (nonatomic, strong) UILabel *timeLbl4;            //进度时间1

@end

@implementation RefundScheduleThirdCell

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
        _titleLbl.font = [UIFont systemFontOfSize:13.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"退款申请已提交，审核通过后，预计7个工作日到账";
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, kScreenWidth - 30, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_progressImg1) {
        _progressImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 65, 10, 10)];
        [_progressImg1 setImage:[UIImage imageNamed:@"退款详情_06"]];
        [self.contentView addSubview:_progressImg1];
    }
    
    if (!_progressImg2) {
        _progressImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(_progressImg1.frame) - 1.5, 75, 3, 40)];
        [_progressImg2 setImage:[UIImage imageNamed:@"退款详情1_03"]];
        [self.contentView addSubview:_progressImg2];
    }
    
    if (!_progressImg3) {
        _progressImg3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 115, 10, 10)];
        [_progressImg3 setImage:[UIImage imageNamed:@"退款详情_06"]];
        [self.contentView addSubview:_progressImg3];
    }
    
    if (!_progressImg4) {
        _progressImg4 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(_progressImg1.frame) - 1.5, 125, 3, 40)];
        [_progressImg4 setImage:[UIImage imageNamed:@"退款详情1_03"]];
        [self.contentView addSubview:_progressImg4];
    }
    
    if (!_progressImg5) {
        _progressImg5 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 165, 10, 10)];
        [_progressImg5 setImage:[UIImage imageNamed:@"退款详情_06"]];
        [self.contentView addSubview:_progressImg5];
    }
    
    if (!_progressImg6) {
        _progressImg6 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(_progressImg1.frame) - 1.5, 175, 3, 40)];
        [_progressImg6 setImage:[UIImage imageNamed:@"退款详情1_03"]];
        [self.contentView addSubview:_progressImg6];
    }
    
    if (!_progressImg7) {
        _progressImg7 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 215, 10, 10)];
        [_progressImg7 setImage:[UIImage imageNamed:@"退款详情_06"]];
        [self.contentView addSubview:_progressImg7];
    }
    
    if (!_desLbl1) {
        _desLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 65, kScreenWidth - 55, 10)];
        _desLbl1.textColor = [UIColor blackColor];
        _desLbl1.font = [UIFont systemFontOfSize:13.0f];
        _desLbl1.text = @"提交申请";
        [self.contentView addSubview:_desLbl1];
    }
    
    if (!_desLbl2) {
        _desLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(40, 115, kScreenWidth - 55, 10)];
        _desLbl2.textColor = [UIColor blackColor];
        _desLbl2.font = [UIFont systemFontOfSize:13.0f];
        _desLbl2.text = @"好园区平台评审";
        [self.contentView addSubview:_desLbl2];
    }
    
    if (!_desLbl3) {
        _desLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(40, 165, kScreenWidth - 55, 10)];
        _desLbl3.textColor = [UIColor blackColor];
        _desLbl3.font = [UIFont systemFontOfSize:13.0f];
        _desLbl3.text = @"审核通过";
        [self.contentView addSubview:_desLbl3];
    }
    
    if (!_desLbl4) {
        _desLbl4 = [[UILabel alloc] initWithFrame:CGRectMake(40, 215, kScreenWidth - 55, 10)];
        _desLbl4.textColor = [UIColor blackColor];
        _desLbl4.font = [UIFont systemFontOfSize:13.0f];
        _desLbl4.text = @"退款通过";
        [self.contentView addSubview:_desLbl4];
    }
    
    if (!_timeLbl1) {
        _timeLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 75, kScreenWidth - 55, 25)];
        _timeLbl1.font = [UIFont systemFontOfSize:10.0f];
        _timeLbl1.textColor = [UIColor grayColor];
        [self.contentView addSubview:_timeLbl1];
    }
    
    if (!_timeLbl2) {
        _timeLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(40, 125, kScreenWidth - 55, 25)];
        _timeLbl2.font = [UIFont systemFontOfSize:10.0f];
        _timeLbl2.textColor = [UIColor grayColor];
        [self.contentView addSubview:_timeLbl2];
    }
    
    if (!_timeLbl3) {
        _timeLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(40, 175, kScreenWidth - 55, 25)];
        _timeLbl3.font = [UIFont systemFontOfSize:10.0f];
        _timeLbl3.textColor = [UIColor grayColor];
        [self.contentView addSubview:_timeLbl3];
    }
    
    if (!_timeLbl4) {
        _timeLbl4 = [[UILabel alloc] initWithFrame:CGRectMake(40, 225, kScreenWidth - 55, 25)];
        _timeLbl4.font = [UIFont systemFontOfSize:10.0f];
        _timeLbl4.textColor = [UIColor grayColor];
        [self.contentView addSubview:_timeLbl4];
    }
}

- (void)setRefundSchedule:(RefundScheduleModel *)refundSchedule
{
    _refundSchedule = refundSchedule;
    
    if (_refundSchedule.tkCreateTime) {
        _timeLbl1.text = [NSString stringWithFormat:@"%@    已受理",_refundSchedule.tkCreateTime];
        [_progressImg1 setImage:[UIImage imageNamed:@"退款详情_03"]];
    }
    
    if (_refundSchedule.tksureTime) {
        _timeLbl2.text = [NSString stringWithFormat:@"%@    已评审",_refundSchedule.tksureTime];
        [_progressImg2 setImage:[UIImage imageNamed:@"退款详情2_03"]];
        [_progressImg3 setImage:[UIImage imageNamed:@"退款详情_03"]];
    }
    
    if (_refundSchedule.tkShTime) {
        _timeLbl3.text = [NSString stringWithFormat:@"%@    审核通过",_refundSchedule.tkShTime];
        [_progressImg4 setImage:[UIImage imageNamed:@"退款详情2_03"]];
        [_progressImg5 setImage:[UIImage imageNamed:@"退款详情_03"]];
    }
    
    if (_refundSchedule.tkSeccessTime) {
        _timeLbl4.text = [NSString stringWithFormat:@"%@    退款成功",_refundSchedule.tkSeccessTime];
        [_progressImg6 setImage:[UIImage imageNamed:@"退款详情2_03"]];
        [_progressImg7 setImage:[UIImage imageNamed:@"退款详情_03"]];
    }
}

@end