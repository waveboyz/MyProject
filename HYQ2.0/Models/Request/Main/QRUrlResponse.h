//
//  QRUrlResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/9.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"

@protocol  QRUrlResponseDelegate<NSObject>
- (void)getQRUrlSucceedWithUrl:(NSString *)url;

@optional

- (void)wrongOperationWithText:(NSString *)text;

@end

@interface QRUrlResponse : HYQResponse

@property (nonatomic, weak) id<QRUrlResponseDelegate> delegate;

@end
