//
//  ReplaceUidResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/6.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    获取头像地址成功后返回uid
 */
@protocol ReplaceUidResponseDelegate <NSObject>

- (void)replaceImageSucceed;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface ReplaceUidResponse : HYQResponse

- (id)initWithUrl:(NSString *)imageUrl;
@property (nonatomic, weak) id<ReplaceUidResponseDelegate> delegate;

@end