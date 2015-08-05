//
//  EditHeaderCell.h
//  HYQ
//
//  Created by 周翔 on 15/6/18.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"

@protocol EditHeaderCellDelegate <NSObject>

- (void)avatarBtnPressed;

@end

@interface EditHeaderCell : UITableViewCell

@property (nonatomic, assign) id<EditHeaderCellDelegate> delegate;

@end
