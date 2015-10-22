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
@protocol ServiceSelectionViewDelegate <NSObject>


@end

@class ProductModel;
@interface ServiceSelectionView : UIView
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) id<ServiceSelectionViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
     andWithProduct:(ProductModel *)product
     andWithTypeArr:(NSMutableArray *)typeArr
            andWith:(NSMutableArray *)comboArr;

@end
