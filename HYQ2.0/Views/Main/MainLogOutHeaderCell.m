//
//  MainHeaderViewCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/17.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MainLogOutHeaderCell.h"
#import "UIButton+WebCache.h"

@interface MainLogOutHeaderCell ()

@property (nonatomic, strong) UIButton *avatarImg;
@property (nonatomic, strong) UILabel  *desLbl;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation MainLogOutHeaderCell

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
        _avatarImg.layer.cornerRadius = CGRectGetWidth(_avatarImg.frame)/2;
        [_avatarImg setImage:[UIImage imageNamed:@"avatar_placeholder"] forState:UIControlStateNormal];
        [_avatarImg addTarget:self action:@selector(avatarImgTouched) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_avatarImg];
    }
    
    if(!_desLbl){
        _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 -100, 155, 200, 20)];
        _desLbl.font = [UIFont systemFontOfSize:13.0f];
        _desLbl.textColor = [UIColor whiteColor];
        _desLbl.text = @"登录签到领取积分可抵现金哦";
        _desLbl.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_desLbl];
    }
    
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(kScreenWidth*0.5 - 60, 190, 120, 30);
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"codeGetIcon"] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnTouched) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_loginBtn];
    }
}

- (void)avatarImgTouched
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(logoutAvatarImgPressed)]) {
        [self.delegate logoutAvatarImgPressed];
    }
}

- (void)loginBtnTouched
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginBtnPressed)]) {
        [self.delegate loginBtnPressed];
    }
}
@end