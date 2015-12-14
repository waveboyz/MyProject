//
//  HYQAdvertiseResponse.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/19.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQResponse.h"

@protocol HYQAdvertiseResponseDelegate <NSObject>

- (void)getAdvertiseSucceedWithUrl:(NSString *)url;
- (void)getAdvertiseFalse;

@end

@interface HYQAdvertiseResponse : HYQResponse

@property (nonatomic, weak) id<HYQAdvertiseResponseDelegate> delegate;

@end