//
//  QRBlurView.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/9.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "QRBlurView.h"
#import "HYQUserManager.h"
#import "UIImageView+WebCache.h"
#import "GlobalConst.h"

@interface QRBlurView ()

@property (nonatomic, strong) UIImageView   *avatarImg;
@property (nonatomic, strong) UIImageView   *QRView;
@property (nonatomic, strong) UILabel       *nameLbl;

@end

@implementation QRBlurView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    NSDictionary *userInfo = [[HYQUserManager sharedUserManager] userInfo];
    _avatarImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 -40, 20, 80, 80)];
    NSString *urlStr = [userInfo objectForKey:@"avatarUrl"];
    [_avatarImg sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    [self addSubview:_avatarImg];

    _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 -60, 120, 120, 30)];
    _nameLbl.font = [UIFont systemFontOfSize:17.0f];
    _nameLbl.textColor = [UIColor blackColor];
    _nameLbl.textAlignment = NSTextAlignmentCenter;
    _nameLbl.text = [userInfo objectForKey:@"username"];
    [self addSubview:_nameLbl];
    
    _QRView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 -75, 180, 150, 150)];
    [self addSubview:_QRView];
}

@end