//
//  ReplaceCodeResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/8.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    个人中心修改密码
 */
@protocol ReplaceCodeResponseDelegate <NSObject>

- (void)replaceCodeSucceed;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface ReplaceCodeResponse : HYQResponse

- (id)initWithCode:(NSString *)code;
@property (nonatomic, assign) id<ReplaceCodeResponseDelegate> delegate;

@end