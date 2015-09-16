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

@interface AppDelegate ()
<
    HYQIntroViewDelegate
>

@property (nonatomic, strong)   BaseTabbarController *tabBarVC;
@property (nonatomic, strong)   HYQIntroView         *introView;
@property (nonatomic, assign)   BOOL                 isLogin;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    _tabBarVC = [[BaseTabbarController alloc] init];
    _isLogin = YES;
    [self.window setRootViewController:_tabBarVC];
    [self.window makeKeyAndVisible];
    [NSThread sleepForTimeInterval:1.5];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults objectForKey:@"intro_screen_viewed"]) {
            self.introView = [[HYQIntroView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            self.introView.delegate = self;
            self.introView.backgroundColor = [UIColor greenColor];
            [self.window addSubview:self.introView];
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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
