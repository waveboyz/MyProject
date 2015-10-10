//
//  GlobalConst.h
//  HYQ
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import <Foundation/Foundation.h>
/*  
    全局常量
 */
#define UME_APPKEY              @"561603e167e58e1e300011e3"
#define QQ_OPEN_ID              @"1104823003"
#define QQ_APPKEY               @"xxMXC8YV3ZOhYMY7"
//------------------界面常量--------------------

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define STATUS_BAR_HEIGHT           20.0f

//------------------色值--------------------

#define USERNAME_COLOR              [UIColor colorWithRed:21.0/255  green:21.0/255  blue:21.0/255   alpha:1]
#define TIME_COLOR                  [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255  alpha:1]
#define NAVIBAR_GREEN_COLOR         [UIColor colorWithRed:142.0/255  green:198.0/255  blue:63.0/255   alpha:1]
//--------------------------------------------
#define ORANGE_COLOR                [UIColor colorWithRed:1.000 green:0.478 blue:0.275  alpha:1]
#define BLUE_COLOR                  [UIColor colorWithRed:0.1   green:0.45  blue:0.79   alpha:1]
#define GRAY_COLOR                  [UIColor colorWithRed:0.925 green:0.925 blue:0.925  alpha:1]
//#define title
#define LINE_COLOR                  [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1]
#define BG_GRAY_COLOR               [UIColor colorWithRed:240.0/255 green:241.0/255 blue:242.0/255 alpha:1]

//------------------Web页面地址--------------------
#define SIGNIN_BASE_URL             @"http://m.haoyuanqu.com/web/weixinpay2/user!topoints.action?id="
#define AGREEMENT_URL               @"http://www.haoyuanqu.com/weixin/web/views/fwu.html"
//-----------------判断屏幕大小--------------------
#define IS_IPHONE5                  [[UIScreen mainScreen] bounds].size.height == 568.0f
#define IS_IHPONE4                  [[UIScreen mainScreen] bounds].size.height == 480.0f
//-----------------资讯活动base------------------------
#define ACTIVITY_BASE_URL           @"http://m.haoyuanqu.com/web/weixinpay2/news!details.action?id="
#define BANK_BASE_URL               @"http://www.haoyuanqu.com/weixin/web/weixinpay2/user!withdrawals.action?localName="
#define LOCAL_HOST                  @"http://www.haoyuanqu.com/"
#define IMAGE_HOST                  @"http://www.haoyuanqu.com/core/resources/"

//-----------------支付宝商户信息------------------------
#define PARTNER                         @"2088021185544262";        //商户
#define SELLER                          @"lili@souqian.com";        //商户支付宝账号
#define PRIVATEKEY                      @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAN3n9xaQvfFQK4o3VjQwSA/PSb2SNV7NHa89Q+4JX/CSRd9NeMv5c3g3cjBaeH+YcCnHxiWO5wbXl9AyTu3wI8+omlEQ/IGOKivzkr7QUTqJ8ZxxQz+JPTSo40Sh6uEZKuIvTJPBevnDEGIkyc1WkLsmmkKDq/ejl3/Vjfr8m40NAgMBAAECgYEAxm5jeX49G8jA5nvNTiXOirSmECrqJrfsz4NNd1JSxGFIsgIo/t018E5EghCkqBS8V+AYxAUhefDYBIi4I/UVTzVKWR22/cLXmCgfAWLem8ynzCEn07uuLm7hd7GjOFVJHd2xib18F1RrOLxGMBfyq5shbslOOv4bHmOfP0WiXgECQQD8tUtX9gRFbBQBJpG7Zdka3aA39NtHdnaceL2LcPNh3E+WdfY/BRZfLaOCtYHkJtliEPj69Dkt/DkXB8aBo1utAkEA4Mv0i9tMQ4eU3TsxLgLRZ8si0WkjpKYcVE0k23lX5gYh5meO2pZeDMVHoBMWY5EX/yeEKYTuOszLEwj2PKci4QJAU71r0yEV9z9CPcNfJV8xm0J3tjMwerTZxy4HeW6baAFOakh6qhVwfWetOEIXYdgxztpa9yX40LE05dnQwOK2HQJAI1cND/ue5rLm7UzD84bP4vBlfeR4jQbsRziFhddywR/ProgzRhwDlyBgnULC7049JojQ1zIlvaq6djifdXOVIQJAYAsov3YNgQ7w6fOYMede9m8IGPx7+QBKUML+7fvcQArb6MWtax08gWBcAi6BocDSFxEkKlHr2d1J1clQlXJuQg==";