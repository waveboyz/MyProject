//
//  WithdrawRecordResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
 我的提成
 
 */
@protocol HYQWithdrawResponseDelegate <NSObject>

- (void)getInfoWith:(NSMutableArray *)infoArr;

@optional

- (void)wrongOperationWithText:(NSString *)text;
- (void)noDataArr;

@end

@interface HYQWithdrawResponse : HYQResponse

@property (nonatomic, assign) id<HYQWithdrawResponseDelegate> delegate;
- (id)initWithType:(NSString *)type andWithCurrentPage:(NSUInteger)page;

@end
