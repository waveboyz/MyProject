//
//  CalculateRefundHeight.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/27.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "CalculateRefundHeight.h"
static CalculateRefundHeight *_calculateHeight;

@implementation CalculateRefundHeight

//实例化
+ (CalculateRefundHeight *)calculate
{
    if (!_calculateHeight) {
        _calculateHeight = [[CalculateRefundHeight alloc] init];
    }
    
    return _calculateHeight;
}

//传入string用于获取高度
- (CGFloat)calculateHeightWithArraycount:(NSInteger)count
{
    if (count) {
        return 60 + 25 * count;
    }
    
    return 60;
}

@end
