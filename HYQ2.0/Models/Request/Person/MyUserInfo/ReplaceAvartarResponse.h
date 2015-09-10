//
//  ReplaceAvartarResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/2.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
#import <UIKit/UIKit.h>
/*
 修改头像
 */
@protocol ReplaceAvartarResponseDelegate <NSObject>

- (void)replaceAvatarSucceedWithUrl:(NSString *)url;
@optional
- (void)wrongOperationWithText:(NSString *)text;

@end

@interface ReplaceAvartarResponse : HYQResponse

@property (nonatomic, assign) id<ReplaceAvartarResponseDelegate> delegate;
- (id)initWith:(UIImage *)image;

@end