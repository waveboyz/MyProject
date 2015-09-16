//
//  BasePersonHeadCell.m
//  TestProject
//
//  Created by 周翔 on 15/6/17.
//
//

#import "BasePersonHeadCell.h"
#import "GlobalConst.h"
#import "UIImageView+WebCache.h"
#import "HYQUserManager.h"

@interface BasePersonHeadCell ()

@property (nonatomic, copy) UIImageView *avatarImg;
@property (nonatomic, copy) UILabel     *nameLbl;
@property (nonatomic, copy) UILabel     *phoneLbl;
@property (nonatomic, copy) UILabel     *lineLbl;

@end

@implementation BasePersonHeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
    }
    
    return self;
}

- (void)setViews
{
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        _avatarImg.layer.cornerRadius = CGRectGetWidth(_avatarImg.frame) / 2;
        _avatarImg.clipsToBounds = YES;
        _avatarImg.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_avatarImg];
    }
    [_avatarImg sd_setImageWithURL:[NSURL URLWithString:[[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"avatarUrl"]] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_avatarImg.frame) + 10, CGRectGetMidY(_avatarImg.frame) - 10, 120, 20)];
        _nameLbl.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_nameLbl];
    }
    _nameLbl.text = [[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"realName"];
 
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, 0.5)];
        _lineLbl.backgroundColor = LINE_COLOR;
        [self.contentView addSubview:_lineLbl];
    }
}

@end
