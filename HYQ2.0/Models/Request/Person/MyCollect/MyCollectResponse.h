//
//  MyCollectResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    我的收藏夹
 */
@protocol MyCollectResponseDelegate <NSObject>

- (void)getCollectListWithArray:(NSMutableArray *)colArr;

@optional

- (void)wrongOperationWithText:(NSString *)text;
- (void)noDataArr;

@end

@interface MyCollectResponse : HYQResponse

@property (nonatomic, weak) id<MyCollectResponseDelegate>delegate;

@end