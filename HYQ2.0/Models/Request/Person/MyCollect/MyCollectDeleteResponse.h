//
//  MyCollectDeleteResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
 批量删除收藏
 */
@protocol MyCollectDeleteResponseDelegate <NSObject>

- (void)deleteSucceed;
- (void)deleteFalse;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface MyCollectDeleteResponse : HYQResponse

@property (nonatomic, assign) id<MyCollectDeleteResponseDelegate>delegate;

- (id)initWithDeleteArr:(NSArray *)array;

@end
