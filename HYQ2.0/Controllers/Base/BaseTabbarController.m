//
//  BaseTabbarController.m
//  TestProject
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanTec. All rights reserved.
//

#import "BaseTabbarController.h"
#import "MainPageViewController.h"
#import "ServiceController.h"
#import "InformationController.h"
#import "ExcellentPlanController.h"
#import "PersonalController.h"
#import "BaseNavigationController.h"

@interface BaseTabbarController ()

@property (nonatomic, strong) BaseNavigationController *firstNav;
@property (nonatomic, strong) BaseNavigationController *secNav;
@property (nonatomic, strong) BaseNavigationController *thirdNav;
@property (nonatomic, strong) BaseNavigationController *forthNav;
@property (nonatomic, retain) UITabBarItem             *firstItem;
@property (nonatomic, retain) UITabBarItem             *secondItem;
@property (nonatomic, retain) UITabBarItem             *thirdItem;
@property (nonatomic, retain) UITabBarItem             *forthItem;
@property (nonatomic, assign) NSUInteger               _currentIndex;

@end

@implementation BaseTabbarController

- (id)init
{
    if (self == [super init]) {
        self.delegate = self;
    }
    
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    MainPageController *firstVC = [[MainPageController alloc] init];
    _firstItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                               image:[UIImage imageNamed:@"tabbar_icon_home"]
                                       selectedImage:[UIImage imageNamed:@"tabbar_icon_home_selected"]];
    _firstNav = [[BaseNavigationController alloc] initWithRootViewController:firstVC];
    _firstNav.tabBarItem = _firstItem;
    
    InformationController *infoVC = [[InformationController alloc] init];
    _secondItem = [[UITabBarItem alloc] initWithTitle:@"资讯活动"
                                                image:[UIImage imageNamed:@"tabbar_icon_timeline"]
                                        selectedImage:[UIImage imageNamed:@"tabbar_icon_timeline_selected"]];
    _secNav = [[BaseNavigationController alloc] initWithRootViewController:infoVC];
    _secNav.tabBarItem = _secondItem;
    
    ServiceController *serVC = [[ServiceController alloc] init];
    _thirdItem = [[UITabBarItem alloc] initWithTitle:@"产品服务"
                                               image:[UIImage imageNamed:@"tabbar_icon_discovery"]
                                       selectedImage:[UIImage imageNamed:@"tabbar_icon_discovery_selected"]];
    _thirdNav = [[BaseNavigationController alloc] initWithRootViewController:serVC];
    _thirdNav.tabBarItem = _thirdItem;
    
    ExcellentPlanController *planVC = [[ExcellentPlanController alloc] init];
    _forthItem = [[UITabBarItem alloc] initWithTitle:@"优创计划"
                                               image:[UIImage imageNamed:@"tabbar_icon_message"]
                                       selectedImage:[UIImage imageNamed:@"tabbar_icon_message_selected"]];
    _forthNav = [[BaseNavigationController alloc] initWithRootViewController:planVC];
    _forthNav.tabBarItem = _forthItem;
    
    self.viewControllers = [NSArray arrayWithObjects:_firstNav,_secNav,_thirdNav,_forthNav ,nil];
    self.tabBar.barTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    self.selectedIndex = 0;
    self.tabBar.tintColor = ORANGE_COLOR;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.selectedIndex  = 0;
    [_firstNav pushViewController:viewController animated:animated];
}

@end