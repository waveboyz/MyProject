//
//  HYQServiceTitleResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    产品页标题类别
 */
@protocol  HYQServiceTitleResponseDelegate<NSObject>

- (void)getTitleWith:(NSArray *)titleArr;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface HYQServiceTitleResponse : HYQResponse

@property (nonatomic, weak) id<HYQServiceTitleResponseDelegate> delegate;

@end