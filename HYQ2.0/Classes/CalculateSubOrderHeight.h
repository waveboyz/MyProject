//
//  CalculateSubOrderHeight.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/27.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CalculateSubOrderHeight : NSObject

//实例化
+ (CalculateSubOrderHeight *)calculate;

//传入string用于获取高度
- (CGFloat)calculateHeightWithArraycount:(NSInteger)count;

@end
