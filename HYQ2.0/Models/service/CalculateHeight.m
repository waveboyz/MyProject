//
//  CalculateHeight.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "CalculateHeight.h"
#import "GlobalConst.h"
static CalculateHeight *_calculate;

@interface CalculateHeight ()

@end
@implementation CalculateHeight

+ (CalculateHeight *)calculate
{
    if (!_calculate) {
        _calculate  = [[CalculateHeight alloc] init];
    }
    
    return _calculate;
}

- (CGFloat)calculateHeightWithString:(NSString *)string
{
    if (string) {
        NSMutableAttributedString *calString = [[NSMutableAttributedString alloc] initWithString:string];
        [calString setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} range:NSMakeRange(0, calString.length)];
        CGSize size = [calString boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 200) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        return size.height;
    }
    
    return 0;
}

@end
