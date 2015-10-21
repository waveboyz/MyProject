//
//  ServiceSelectionView.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/19.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
    产品选择页
 */
@interface ServiceSelectionView : UIView
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, strong) UITableView *tableView;

@end
