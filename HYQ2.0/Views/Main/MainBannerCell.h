//
//  MainBannerCell.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/26.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"
/*
    首页banner cell
 */
@protocol MainBannerCellDelegate <NSObject>

- (void)didSelectedBannerWithUrl:(NSString *)url;

@end

@interface MainBannerCell : UITableViewCell

@property (nonatomic, weak) id<MainBannerCellDelegate> delegate;
@property (nonatomic, assign) NSArray *imgArr;

@end
