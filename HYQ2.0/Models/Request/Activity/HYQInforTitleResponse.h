//
//  HYQActivityResponse.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/25.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    咨询类别
 */

@protocol  HYQInforTitleResponseDelegate<NSObject>

- (void)getInfoWith:(NSArray *)dataArr;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface HYQInforTitleResponse : HYQResponse

@property (nonatomic, weak) id<HYQInforTitleResponseDelegate> delegate;


@end