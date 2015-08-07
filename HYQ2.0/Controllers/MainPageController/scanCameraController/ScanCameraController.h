//
//  scanCameraController.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/5.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "GlobalConst.h"

typedef void(^QRUrlBlock)(NSString *url);

@interface ScanCameraController : UIViewController
<
    AVCaptureMetadataOutputObjectsDelegate
>

@property (nonatomic, copy) QRUrlBlock qrUrlBlock;

@end
