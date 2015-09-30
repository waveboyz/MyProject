//
//  MainLogInHeaderCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/18.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MainLogInHeaderCell.h"
#import "UIButton+WebCache.h"
#import "HYQUserManager.h"

@interface MainLogInHeaderCell ()

@property (nonatomic, strong) UIButton *avatarImg;
@property (nonatomic, strong) UILabel  *nameLbl;
@property (nonatomic, strong) UILabel  *desLbl;
@property (nonatomic, strong) UILabel  *propertyLbl;

@end

@implementation MainLogInHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = NAVIBAR_GREEN_COLOR;
    }

    return self;
}


- (void)setViews
{

    if (!_avatarImg) {
        _avatarImg = [UIButton buttonWithType:UIButtonTypeCustom];
        _avatarImg.frame = CGRectMake(kScreenWidth * 0.5 - 44, 55, 88, 88);
        _avatarImg.clipsToBounds = YES;
        _avatarImg.layer.cornerRadius = CGRectGetWidth(_avatarImg.frame)/2;
        [_avatarImg sd_setImageWithURL:[NSURL URLWithString:[[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"avatarUrl"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
        [_avatarImg addTarget:self action:@selector(avatarImgTouched) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_avatarImg];
    }
    
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 50, 145, 100, 15)];
        _nameLbl.font = [UIFont systemFontOfSize:13.0f];
        _nameLbl.textColor = [UIColor whiteColor];
        _nameLbl.textAlignment = NSTextAlignmentCenter;
        _nameLbl.text = [[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"phone"];
        [self.contentView addSubview:_nameLbl];
    }
    
    if (!_desLbl) {
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 40, 170, 80, 15)];
        _desLbl.font = [UIFont systemFontOfSize:13.0f];
        _desLbl.textColor = [UIColor whiteColor];
        _desLbl.textAlignment = NSTextAlignmentCenter;
        _desLbl.text = @"余额（元）";
        [self.contentView addSubview:_desLbl];
    }
    
    if (!_propertyLbl) {
        _propertyLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 80, 190, 160, 35)];
        _propertyLbl.font = [UIFont systemFontOfSize:43.0];
        _propertyLbl.textAlignment = NSTextAlignmentCenter;
        _propertyLbl.textColor = [UIColor whiteColor];
        if ([[[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"property"] isKindOfClass:[NSString class]]) {
            _propertyLbl.text = [[[HYQUserManager sharedUserManager] userInfo]objectForKey:@"property"];
        }
        [self.contentView addSubview:_propertyLbl];
    }
}


- (void)avatarImgTouched
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(avatarImgPressed)]) {
        [self.delegate avatarImgPressed];
    }
}

@end