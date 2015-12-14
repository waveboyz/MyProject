//
//  MyOrderDeleteResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
    订单删除
 */
@protocol MyOrderDeleteResponseDelegate <NSObject>

- (void)deleteSucceed;
@optional
- (void)wrongOperationWithText:(NSString *)text;

@end

@interface MyOrderDeleteResponse : HYQResponse

@property (nonatomic, weak) id<MyOrderDeleteResponseDelegate> delegate;

- (id)initWithOid:(NSUInteger)oid andWithPayID:(NSNumber *)payID;

@end
