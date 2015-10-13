//
//  UIImageExtension.h
//  HYQ2.0
//
//  Created by 周翔 on 15/10/13.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(HYQExtension)

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;
- (CIImage *)createQRForString:(NSString *)qrString;
- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

@end
