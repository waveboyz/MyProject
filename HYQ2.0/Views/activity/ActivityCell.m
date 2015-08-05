//
//  activityCell.m
//  HYQ
//
//  Created by 周翔 on 15/6/25.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "ActivityCell.h"

@interface ActivityCell ()

@property (nonatomic, retain) UILabel *titleLbl;
@property (nonatomic, retain) UILabel *beginLbl;
@property (nonatomic, retain) UILabel *endLbl;
@property (nonatomic, retain) UILabel *locLbl;
@property (nonatomic, retain) UIButton *joinBtn;
@property (nonatomic, retain) UILabel *lineLbl;;

@end

@implementation ActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    if (!self.titleLbl) {
        self.titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 30)];
        self.titleLbl.textColor = USERNAME_COLOR;
        self.titleLbl.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:self.titleLbl];
    }
    
    if (!self.beginLbl) {
        self.beginLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, kScreenWidth - 20, 20)];
        self.beginLbl.textColor = TIME_COLOR;
        self.beginLbl.font = [UIFont systemFontOfSize:10.0f];
        [self.contentView addSubview:self.beginLbl];
    }

    if (!self.endLbl) {
        self.endLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, kScreenWidth - 20, 20)];
        self.endLbl.textColor = TIME_COLOR;
        self.endLbl.font = [UIFont systemFontOfSize:10.0f];
        [self.contentView addSubview:self.endLbl];
    }
    
    if (!self.locLbl) {
        self.locLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, kScreenWidth - 20, 20)];
        self.locLbl.textColor = TIME_COLOR;
        self.locLbl.font = [UIFont systemFontOfSize:10.0f];
        [self.contentView addSubview:self.locLbl];
    }
    
    if (!self.joinBtn) {
        self.joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.joinBtn setFrame:CGRectMake(10, 100, 120, 30)];
        self.joinBtn.layer.cornerRadius = 10.0f;
        [self.joinBtn setTitle:@"报名" forState:UIControlStateNormal];
        
        [self.contentView addSubview:self.joinBtn];
    }
    
    if (!self.lineLbl) {
        self.lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, kScreenWidth, 10)];
        self.lineLbl.backgroundColor = BG_GRAY_COLOR;
        
        [self.contentView addSubview:self.lineLbl];
    }
}

- (void)setActivityData:(ActivityModel *)activityData
{
    self.titleLbl.text = activityData.title;
    self.beginLbl.text = activityData.begin_time;
    self.endLbl.text = activityData.end_time;
    self.locLbl.text = activityData.location;
    
    if (activityData.is_end) {
        [self.joinBtn setTitle:@"已结束" forState:UIControlStateNormal];
        [self.joinBtn setBackgroundColor:GRAY_COLOR];
    }else{
        [self.joinBtn setTitle:@"未开始" forState:UIControlStateNormal];
        [self.joinBtn setBackgroundColor:ORANGE_COLOR];
    }
}

@end
