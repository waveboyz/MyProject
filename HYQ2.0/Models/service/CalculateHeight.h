//
//  CalculateHeight.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CalculateHeight : NSObject

+ (CalculateHeight *)calculate;
- (CGFloat)calculateHeightWithString:(NSString *)string;

@end
