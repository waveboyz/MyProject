//
//  SecondViewController.m
//  TestProject
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanTec. All rights reserved.
//

#import "MainPageViewController.h"
#import "HYQLoginController.h"
#import "PersonalController.h"
#import "SDCycleScrollView.h"

@interface MainPageController ()

@property (nonatomic, retain) UIScrollView *scrollBGView;
@property (nonatomic, strong) NSMutableArray *imgArr;

@end

@implementation MainPageController

- (id)init
{
    if (self = [super init]) {
        NSString *stringPath = [[NSBundle mainBundle] pathForResource:@"URLS.plist" ofType:nil];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:stringPath];
        NSArray *dicArr = [dic objectForKey:@"urls"];
        self.imgArr = [NSMutableArray arrayWithArray:dicArr];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_icon_person"]
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(showPersonalBtnPressed)];
    
    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"scanIcon"]
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(showScanPressed)];
    
    UIBarButtonItem *rightBtn2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"QRIcon"]
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(showQRcodePressed)];
    
    self.navigationItem.rightBarButtonItems = @[rightBtn1,rightBtn2];
    [self.navigationItem setLeftBarButtonItem:leftBtn animated:YES];

    self.view.backgroundColor = BG_GRAY_COLOR;
    self.title = @"首页";
    [self createUI];
}

- (void)createUI
{
    self.scrollBGView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scrollBGView.backgroundColor = BG_GRAY_COLOR;
    self.scrollBGView.showsVerticalScrollIndicator = NO;
    
    if (IS_IHPONE4) {
        self.scrollBGView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 90);
    }
    if (IS_IPHONE5) {
        self.scrollBGView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 99);
    }
    
    [self.view addSubview:self.scrollBGView];
    //图片轮播...view
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, kScreenWidth, 160) imageURLStringsGroup:self.imgArr];
    cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleView.placeholderImage = [UIImage imageNamed:@"notice_place_holder"];
    cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    [self.view addSubview:cycleView];
    
    //园区资讯...view
    CGFloat buttonWidth = (kScreenWidth -15) / 2;
    CGFloat buttonHeight = (200 -15) / 2;
}

- (void)showPersonalBtnPressed
{
    PersonalController *loginVC = [[PersonalController alloc] init];
    loginVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)showQRcodePressed
{
    
}

- (void)showScanPressed
{
    
}

@end
