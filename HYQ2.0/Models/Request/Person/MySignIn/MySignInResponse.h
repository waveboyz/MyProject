//
//  MySignInResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/30.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"

@protocol MySignInResponseDelegate <NSObject>

- (void)getSignArrSucceedWith:(NSArray *)arr andWithNum:(NSNumber *)num;
@optional

- (void)wrongOperationWithText:(NSString *)text;
- (void)noDataArr;

@end

@interface MySignInResponse : HYQResponse

@property (nonatomic, weak) id<MySignInResponseDelegate> delegate;

@end
