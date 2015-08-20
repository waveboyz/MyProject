//
//  MainLogInHeaderCell.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/18.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"

@protocol MainLogInHeaderCellDelegate <NSObject>

- (void)avatarImgPressed;

@end

@interface MainLogInHeaderCell : UITableViewCell

@property (nonatomic, assign) id<MainLogInHeaderCellDelegate> delegate;

@end