//
//  CalculateButtonHeight.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/22.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "CalculateButtonHeight.h"

static CalculateButtonHeight *_calculateHeight;

@implementation CalculateButtonHeight
//实例化
+ (CalculateButtonHeight *)calculate
{
    if (!_calculateHeight) {
        _calculateHeight = [[CalculateButtonHeight alloc] init];
    }
    
    return _calculateHeight;
}

//传入string用于获取高度
- (CGFloat)calculateHeightWithString:(NSInteger)count
{
    if (count) {
        if (count <= 3) {
            return 100.5f;
        }
        
        return 60.5 + 40 * (count/3 + 1);
    }
    
    return 100.5f;
}
@end
