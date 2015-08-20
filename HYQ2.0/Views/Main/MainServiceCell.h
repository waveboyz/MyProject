//
//  MainServiceCell.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"

@protocol MainServiceCellDelegate <NSObject>

- (void)iconBtnTouchWithTag:(NSInteger)tag;

@end

@interface MainServiceCell : UITableViewCell

@property (nonatomic, assign) id<MainServiceCellDelegate> delegate;

@end