//
//  BaseNavigationController.m
//  TestProject
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanTec. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseTabbarController.h"

@interface BaseNavigationController ()

@property (nonatomic, retain) BaseTabbarController *tabbarController;
- (void)popSelf;

@end

@implementation BaseNavigationController
- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationBar.barTintColor                 = NAVIBAR_GREEN_COLOR;
        self.navigationBar.titleTextAttributes          = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
        self.interactivePopGestureRecognizer.enabled    = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - 自定义返回按钮
- (void)popSelf
{
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    [viewController didMoveToParentViewController:self];
    
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1) {
        
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    } else {
        return YES;
    }
    
    return YES;
}

- (BOOL)shouldAutorotate
{
    if ([self.viewControllers.lastObject isKindOfClass:[UIViewController class]]) {
        return YES;
    }
    
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end
