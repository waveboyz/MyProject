//
//  EditHeaderCell.m
//  HYQ
//
//  Created by 周翔 on 15/6/18.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "EditHeaderCell.h"
#import "UIButton+WebCache.h"

@interface EditHeaderCell ()

@property (nonatomic, copy) UIView *bgView;
@property (nonatomic, copy) UIButton *avatarBtn;

@end

@implementation EditHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
    }
    return self;
}

- (void)setViews
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
        _bgView.backgroundColor = NAVIBAR_GREEN_COLOR;
        
        [self.contentView addSubview:_bgView];
    }

    if (!_avatarBtn) {
        _avatarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _avatarBtn.frame = CGRectMake(kScreenWidth * 0.5 - 40, 20, 80, 80);
        _avatarBtn.layer.cornerRadius = CGRectGetWidth(_avatarBtn.frame)/2;
        _avatarBtn.clipsToBounds = YES;
        _avatarBtn.contentMode = UIViewContentModeScaleAspectFill;
        [_avatarBtn addTarget:self action:@selector(pressAvatarBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        [_avatarBtn sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
        
        [_bgView addSubview:_avatarBtn];
    }
}

- (void)pressAvatarBtnEvent
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(avatarBtnPressed)]) {
        [self.delegate avatarBtnPressed];
    }
}

@end
