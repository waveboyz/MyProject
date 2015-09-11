//
//  MyAddressCorrectResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/8/31.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"
/*
 修改地址
 */
@protocol MyAddressCorrectResponseDelegate <NSObject>

- (void)correctSucceedWith:(NSNumber *)aid;

@optional
- (void)wrongOperationWithText:(NSString *)text;

@end

@interface MyAddressCorrectResponse : HYQResponse

@property (nonatomic, assign) id<MyAddressCorrectResponseDelegate>delegate;

- (id)initWithEnterprise:(NSString *)enterprise
             andWithName:(NSString *)name
            andWithPhone:(NSString *)phone
          andWithAddress:(NSString *)address
         andWithProvince:(NSString *)province
                 andCity:(NSString *)city
                andState:(NSString *)state
               andTacity:(NSUInteger)tacity
                 andWithAid:(NSString *)aid;
@end