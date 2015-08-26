//
//  MainHeaderViewCell.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/17.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"

@protocol MainLogOutHeaderCellDelegate <NSObject>

- (void)logoutAvatarImgPressed;
- (void)loginBtnPressed;

@end

@interface MainLogOutHeaderCell : UITableViewCell

@property (nonatomic, assign) id<MainLogOutHeaderCellDelegate> delegate;

@end