//
//  ProductTypeCell.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
    产品选择页服务类型
 */
@class ProductTypeModel;
@protocol ProductTypeCellDlegate <NSObject>

- (void)selectTypeModel:(ProductTypeModel *)type;

@end

@interface ProductTypeCell : UITableViewCell

@property (nonatomic, retain) NSArray *typeArr;
@property (nonatomic, weak) id<ProductTypeCellDlegate>delegate;

@end
