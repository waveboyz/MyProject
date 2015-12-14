//
//  ProductModel.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/20.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "BaseModel.h"
/*
    产品详情模型
 */
@interface ProductModel : BaseModel

@property (nonatomic, copy) NSString *contentText;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, strong) NSNumber *xiangou;
@property (nonatomic, strong) NSNumber *oldPrice;
@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSNumber *price;

@end