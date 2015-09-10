//
//  HYQReplaceUsername.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/8.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    修改昵称
 */
@protocol HYQReplaceUsernameDelegate <NSObject>

- (void)replaceUsernameSucceed;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface HYQReplaceUsername : HYQResponse

- (id)initWithNickName:(NSString *)username;

@property (nonatomic, assign) id<HYQReplaceUsernameDelegate> delegate;

@end