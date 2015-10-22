//
//  ServiceIsCollectResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/7.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    收藏请求
 */
@class ProductModel;
@class EvaluateModel;

@protocol ServiceIsCollectResponseDelegate <NSObject>

- (void)getCollectSucceedWithIsCollected:(BOOL)isCollected
                                 andWith:(ProductModel *)product
                                 andWith:(EvaluateModel *)evaluate
                                 andWith:(NSMutableArray *)comboArr
                                 andwith:(NSMutableArray *)typeArr;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface ServiceIsCollectResponse : HYQResponse

- (id)initWithPid:(NSNumber *)pid andWithPTID:(NSNumber *)ptid;

@property (nonatomic, weak) id<ServiceIsCollectResponseDelegate> delegate;

@end
