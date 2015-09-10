//
//  CollectOperationResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    产品详情页收藏
 */
@protocol CollectOperationResponseDelegate <NSObject>

- (void)collectSucceed;

- (void)deCollectSucceed;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface CollectOperationResponse : HYQResponse

@property (nonatomic, assign) id<CollectOperationResponseDelegate> delegate;
- (id)initWithPid:(NSNumber *)pid;

@end