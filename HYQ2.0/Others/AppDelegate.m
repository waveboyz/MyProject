//
//  AppDelegate.m
//  HYQ2.0
//
//  Created by waveboyz on 15/7/27.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "AppDelegate.h"
#import "GlobalConst.h"
#import "BaseTabbarController.h"
#import "PersonalController.h"
#import "HYQIntroView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "HYQAdvertiseResponse.h"
#import "UIImageView+WebCache.h"

@interface AppDelegate ()
<
    HYQIntroViewDelegate,
    HYQAdvertiseResponseDelegate
>

@property (nonatomic, strong)   BaseTabbarController *tabBarVC;
@property (nonatomic, strong)   HYQIntroView         *introView;
@property (nonatomic, strong)   UIImageView          *adView;
@property (nonatomic, assign)   BOOL                 isLogin;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    _tabBarVC = [[BaseTabbarController alloc] init];
    _isLogin = YES;
    [self.window setRootViewController:_tabBarVC];
    [self.window makeKeyAndVisible];
//    [NSThread sleepForTimeInterval:1.5];
//    HYQAdvertiseResponse *response = [[HYQAdvertiseResponse alloc] init];
//    response.delegate = self;
//    [response start];

    [UMSocialData setAppKey:UME_APPKEY];
    [UMSocialQQHandler setQQWithAppId:QQ_OPEN_ID appKey:QQ_APPKEY url:LOCAL_HOST];
    [UMSocialWechatHandler setWXAppId:WECHAT_ID appSecret:WECHAT_APPKEY url:LOCAL_HOST];

//    _adView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    [self.window bringSubviewToFront:_adView];
//    [self.window addSubview:_adView];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"intro_screen_viewed"]) {
        self.introView = [[HYQIntroView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.introView.delegate = self;
        self.introView.backgroundColor = [UIColor greenColor];
        [self.window addSubview:self.introView];
        [self.window insertSubview:self.introView belowSubview:self.adView];
    }
    
    return YES;
}

-(void)onDoneButtonPressed
{
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"viewed" forKey:@"intro_screen_viewed"];
    }];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //如果极简开发包不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给开 发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      NSLog(@"result = %@",resultDic);
                                                  }]; }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(nonnull NSURL *)url
{
    return [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options
{
    return [UMSocialSnsService handleOpenURL:url];
}

//#pragma mark HYQAdvertiseResponseDelegate
//- (void)getAdvertiseSucceedWithUrl:(NSString *)url
//{
//    [_adView sd_setImageWithURL:[NSURL URLWithString:url]];
//    [UIView animateWithDuration:3.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        _adView.alpha = 0;
//    } completion:^(BOOL finished) {
//        [self.adView removeFromSuperview];
//    }];
//}
//
//- (void)getAdvertiseFalse
//{
//    [self.adView removeFromSuperview];
//}

@end
