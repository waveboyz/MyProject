//
//  MainHeaderViewCell.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/17.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"

@protocol MainHeaderViewCellDelegate <NSObject>

- (void)avatarImgPressed;
- (void)loginBtnPressed;

@end

@interface MainHeaderViewCell : UITableViewCell

@property (nonatomic, assign) id<MainHeaderViewCellDelegate> delegate;

@end