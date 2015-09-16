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
@protocol ServiceIsCollectResponseDelegate <NSObject>

- (void)getCollectSucceedWithIsCollected:(BOOL)isCollected;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface ServiceIsCollectResponse : HYQResponse

- (id)initWithPid:(NSNumber *)pid;

@property (nonatomic, assign) id<ServiceIsCollectResponseDelegate> delegate;

@end
