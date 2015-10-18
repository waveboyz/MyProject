//
//  QRBlurView.h
//  HYQ2.0
//
//  Created by 周翔 on 15/9/9.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QRBlurViewDelegate <NSObject>

- (void)shareQRCodeWithUrl:(NSString *)url;

@end

@interface QRBlurView : UIView

@property (nonatomic, weak) id<QRBlurViewDelegate> delegate;

@end