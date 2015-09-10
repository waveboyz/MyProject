//
//  HYQMainResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/26.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"

@protocol HYQmainResponseDelegate <NSObject>

- (void)getMainInformationSucceedWithImgArr:(NSArray *)imgArr andWithProducts:(NSArray *)products andWithInfo:(NSArray *)information;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface HYQMainResponse : HYQResponse

@property (nonatomic, assign) id<HYQmainResponseDelegate> delegate;

@end