//
//  MainScrollinfoCell.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/20.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"
/*
    首页滚动新闻
 */
@protocol MainScrollinfoCellDelegate <NSObject>

- (void)infoCellTouchedWithUrl:(NSString *)url andWithTitle:(NSString *)title;

@end

@interface MainScrollinfoCell : UITableViewCell
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, assign) NSArray *titleArr;
@property (nonatomic, assign) id<MainScrollinfoCellDelegate> delegate;

@end