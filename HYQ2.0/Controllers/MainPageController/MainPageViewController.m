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
#import "scanCameraController.h"
#import "HYQResponse.h"

@interface MainPageController ()

@property (nonatomic, retain) UIScrollView *scrollBGView;
@property (nonatomic, assign) NSMutableArray *imgArr;

@end

@implementation MainPageController

- (id)init
{
    if (self = [super init]) {

    }
    return self;
}

- (NSMutableArray *)imgArr
{
    NSString *stringPath = [[NSBundle mainBundle] pathForResource:@"URLS.plist" ofType:nil];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:stringPath];
    NSArray *dicArr = [dic objectForKey:@"urls"];
    NSMutableArray *listArr = [NSMutableArray arrayWithArray:dicArr];
    
    return listArr;
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
    self.scrollBGView.alwaysBounceVertical = YES;
    
    if (IS_IHPONE4) {
        self.scrollBGView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 90);
    }
    if (IS_IPHONE5) {
        self.scrollBGView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 99);
    }
    
    [self.view addSubview:self.scrollBGView];
    //图片轮播...view
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 120, kScreenWidth, 160) imageURLStringsGroup:self.imgArr];
    cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleView.placeholderImage = [UIImage imageNamed:@"notice_place_holder"];
    cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    [self.scrollBGView addSubview:cycleView];
    //园区资讯...view
//    CGFloat buttonWidth = (kScreenWidth -15) / 2;
//    CGFloat buttonHeight = (200 -15) / 2;
}

- (BOOL)validateCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
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
    if ([self validateCamera]) {
        ScanCameraController *scanVC = [[ScanCameraController alloc] init];
        [self.navigationController pushViewController:scanVC animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此设备不具备扫码功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }

}

@end