//
//  ExcellentHeaderCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/5.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ExcellentHeaderCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface ExcellentHeaderCell ()

@property (nonatomic, strong) UIImageView   *headerView;
@property (nonatomic, strong) UILabel       *titleLbl;
@property (nonatomic, strong) UIButton      *firstIcon;
@property (nonatomic, strong) UIButton      *secondIcon;
@property (nonatomic, strong) UIButton      *thirdIcon;
@property (nonatomic, strong) UIButton      *forthIcon;
@property (nonatomic, strong) UILabel       *firstLbl;
@property (nonatomic, strong) UILabel       *secondLbl;
@property (nonatomic, strong) UILabel       *thirdLbl;
@property (nonatomic, strong) UILabel       *forthLbl;
@property (nonatomic, strong) UIVisualEffectView    *blurview;
@property (nonatomic, strong) UIView        *grayview;

@end

@implementation ExcellentHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setViews];
    }
    
    return self;
}

- (void)setViews
{
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        [_headerView sd_setImageWithURL:[NSURL URLWithString:@"http://f8.topit.me/8/ed/67/110248312730a67ed8o.jpg"]placeholderImage:[UIImage imageNamed:@"notice_place_holder"]];
        [self.contentView addSubview:_headerView];
    }
    
//    if (!_blurview) {
//        _blurview = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//        _blurview.frame = CGRectMake(0, 0, kScreenWidth, 150);
//        _blurview.alpha = 0.9;
//        
//        [self.contentView addSubview:_blurview];
//    }
    if (!_grayview) {
        _grayview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        _grayview.backgroundColor = [UIColor blackColor];
        _grayview.alpha = 0.2f;
        
        [self.contentView addSubview:_grayview];
    }
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMidY(_headerView.frame) - 60, kScreenWidth - 20, 120)];
        _titleLbl.font = [UIFont systemFontOfSize:15.0f];
        _titleLbl.textAlignment = NSTextAlignmentLeft;
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.numberOfLines = 4;
        _titleLbl.text = @"将通过对参加的项目进行包括""优创金融方案、优创基地、优创训练营、优创开放日""等环节进行培育辅导最终完成项目的孵化、加速、成熟的成长壮大过程。";
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_firstIcon) {
        _firstIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:_firstIcon];
    }
    
    if (!_secondIcon) {
        _secondIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:_secondIcon];
    }
    
    if (!_thirdIcon) {
        _thirdIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:_thirdIcon];
    }
    
    if (!_forthIcon) {
        _forthIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:_forthIcon];
    }
    
    if (!_firstLbl) {
        _firstLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _firstLbl.font = [UIFont systemFontOfSize:13.0f];
        _firstLbl.textAlignment = NSTextAlignmentCenter;
        _firstLbl.text = @"优创金融方案";
        _firstLbl.center = _firstIcon.center;
        
        [self.contentView addSubview:_firstLbl];
    }
    
    if (!_secondLbl) {
        _secondLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _secondLbl.font = [UIFont systemFontOfSize:13.0f];
        _secondLbl.textAlignment = NSTextAlignmentCenter;
        _secondLbl.text = @"优创基地";
        _secondLbl.center = _secondIcon.center;
        
        [self.contentView addSubview:_secondLbl];
    }
    
    if (!_thirdLbl) {
        _thirdLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _thirdLbl.font = [UIFont systemFontOfSize:13.0f];
        _thirdLbl.textAlignment = NSTextAlignmentCenter;
        _thirdLbl.text = @"优创训练营";
        _thirdLbl.center = _thirdIcon.center;
        
        [self.contentView addSubview:_thirdLbl];
    }
    
    if (!_forthLbl) {
        _forthLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _forthLbl.font = [UIFont systemFontOfSize:13.0f];
        _forthLbl.textAlignment = NSTextAlignmentCenter;
        _forthLbl.text = @"优创开放日";
        _forthLbl.center = _forthLbl.center;
        
        [self.contentView addSubview:_forthLbl];
    }
}

@end
