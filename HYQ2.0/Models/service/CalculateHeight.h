//
//  CalculateHeight.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
    用户计算动态高度
 */
@interface CalculateHeight : NSObject

//实例化
+ (CalculateHeight *)calculate;

//传入string用于获取高度
- (CGFloat)calculateHeightWithString:(NSString *)string;

@end
