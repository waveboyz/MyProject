//
//  QRBlurView.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/9.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "QRBlurView.h"
#import "HYQUserManager.h"
#import "UIImageView+WebCache.h"
#import "GlobalConst.h"
#import "HYQInterfaceMethod.h"
#import "UIImageExtension.h"

@interface QRBlurView ()

@property (nonatomic, strong) UIImageView   *avatarImg;
@property (nonatomic, strong) UIImageView   *QRView;
@property (nonatomic, strong) UILabel       *nameLbl;
@property (nonatomic, strong) UILabel       *linkLbl;
@property (nonatomic, strong) UIButton      *shareBtn;
@property (nonatomic, copy)   NSString      *shareUrl;

@end

@implementation QRBlurView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    self.backgroundColor = [UIColor whiteColor];
    NSDictionary *userInfo = [[HYQUserManager sharedUserManager] userInfo];
    NSString *phone = [userInfo objectForKey:@"phone"];
    NSData *unencodeData = [phone dataUsingEncoding:NSUTF8StringEncoding];
    // 将手机号base64加密
    NSString *encoddeStr = [unencodeData base64EncodedStringWithOptions:0];
    //由于web打开base64末端“=”不可行
    NSString *subStr = [encoddeStr substringWithRange:NSMakeRange(0, encoddeStr.length -2)];
    //将末端“=”替换“_”
    NSString *finalStr = [NSString stringWithFormat:@"%@_",subStr];
    //最终分享url
   _shareUrl = [NSString stringWithFormat:@"%@%@",GET_QRURL_INTERFACE,finalStr];
    
    _avatarImg = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 40)*0.5 - 40, 20, 80, 80)];
    _avatarImg.layer.cornerRadius = CGRectGetWidth(_avatarImg.frame)/2;
    NSString *urlStr = [userInfo objectForKey:@"avatarUrl"];
    [_avatarImg sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    [self addSubview:_avatarImg];

    _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 40)* 0.5 -60, 120, 120, 30)];
    _nameLbl.font = [UIFont systemFontOfSize:17.0f];
    _nameLbl.textColor = [UIColor blackColor];
    _nameLbl.textAlignment = NSTextAlignmentCenter;
    _nameLbl.text = [userInfo objectForKey:@"realName"];
    [self addSubview:_nameLbl];
    
    _QRView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 40)* 0.5 -75, 180, 150, 150)];
    UIImage *qrcode =[[UIImage alloc] createNonInterpolatedUIImageFormCIImage:[self createQRForString:_shareUrl] withSize:250.f];
    UIImage *customQrcode =[[UIImage alloc] imageBlackToTransparent:qrcode withRed:60.0f andGreen:74.0f andBlue:89.0f];
    _QRView.image = customQrcode;
    [self addSubview:_QRView];
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtn.frame = CGRectMake((kScreenWidth - 40) * 0.5 - 50, 340, 100, 30);
    _shareBtn.layer.cornerRadius = CGRectGetWidth(_shareBtn.frame) / 8;
    [_shareBtn addTarget:self action:@selector(shareBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_shareBtn setBackgroundColor:NAVIBAR_GREEN_COLOR];
    [_shareBtn setTitle:@"点击分享" forState:UIControlStateNormal];
    [_shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_shareBtn];
}

- (void)shareBtnPressed
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareQRCodeWithUrl:)]) {
        [self.delegate shareQRCodeWithUrl:_shareUrl];
    }
}

#pragma mark - QRCodeGenerator
- (CIImage *)createQRForString:(NSString *)qrString
{
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}

@end