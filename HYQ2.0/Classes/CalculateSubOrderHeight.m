//
//  CalculateSubOrderHeight.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/27.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "CalculateSubOrderHeight.h"
static CalculateSubOrderHeight *_calculateHeight;

@implementation CalculateSubOrderHeight
//实例化
+ (CalculateSubOrderHeight *)calculate
{
    if (!_calculateHeight) {
        _calculateHeight = [[CalculateSubOrderHeight alloc] init];
    }
    
    return _calculateHeight;
}

//传入string用于获取高度
- (CGFloat)calculateHeightWithArraycount:(NSInteger)count
{
    if (count) {
        return 90 + 25 * count;
    }else{
        return 90;
    }
}
@end
