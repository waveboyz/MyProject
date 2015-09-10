//
//  ExcellentHeaderCell.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/5.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"

@protocol ExcellentHeaderCellDelegate <NSObject>

- (void)iconTouchedWithTag:(NSInteger)tag;

@end

@interface ExcellentHeaderCell : UITableViewCell

@property (nonatomic,assign) id<ExcellentHeaderCellDelegate> delegate;

@end
