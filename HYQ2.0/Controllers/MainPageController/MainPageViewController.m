//
//  SecondViewController.m
//  TestProject
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanTec. All rights reserved.
//

#import "MainPageViewController.h"
#import "HYQUserManager.h"
#import "SDCycleScrollView.h"
#import "HYQResponse.h"
#import "UINavigationBar+Awesome.h"
//------------------------------
#import "MainLogOutHeaderCell.h"
#import "MainLogInHeaderCell.h"
#import "MainServiceCell.h"
#import "MainScrollinfoCell.h"
//----------------------------
#import "ExcellentBaseController.h"
#import "ExcellentCampController.h"
#import "ExcellentFinantialController.h"
#import "ExcellentOpenDayController.h"
#import "scanCameraController.h"
#import "HYQLoginController.h"
#import "PersonalController.h"
//----------------------------
#import "ServiceModel.h"
#import "ActivityModel.h"

#define NAVBAR_CHANGE_POINT 50

@interface MainPageController ()
<
    MainLogOutHeaderCellDelegate,
    MainLogInHeaderCellDelegate,
    MainServiceCellDelegate
>

@property (nonatomic, retain) UIScrollView *scrollBGView;
@property (nonatomic, assign) NSMutableArray *imgArr;
@property (nonatomic, strong) UITableView *tableview;

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
    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"scan_icon"]
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(showScanPressed)];
    
    UIBarButtonItem *rightBtn2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"QRIcon"]
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(showQRcodePressed)];

    self.navigationItem.rightBarButtonItems = @[rightBtn1,rightBtn2];
    self.view.backgroundColor = BG_GRAY_COLOR;
    [self createUI];
}

- (void)createUI
{
    UIButton *imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 38)];
    imgBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    imgBtn.layer.cornerRadius = CGRectGetWidth(imgBtn.frame)/4;
    [imgBtn addTarget:self action:@selector(avatarImgPressed) forControlEvents:UIControlEventTouchUpInside];
    [imgBtn sd_setImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    [self.navigationItem setTitleView:imgBtn];
    self.navigationItem.titleView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight + 64) style:UITableViewStylePlain];
    self.tableview.backgroundColor = GRAY_COLOR;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableview.delegate = self;
    [self scrollViewDidScroll:self.tableview];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin) name:@"didLogin" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableview.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"didLogin" object:nil];
}

- (void)userDidLogin
{
    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *HEADER_CELL = @"header_cell";
    static NSString *SECOND_CELL = @"second_cell";
    static NSString *SERVICE_CELL = @"service_cell";
    static NSString *SCROLL_CELL = @"scroll_cell";
    static NSString *THIRD_CELL = @"third_cell";
    
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:HEADER_CELL];
        if (!cell) {
//            if ([[HYQUserManager sharedUserManager] isLogin]) {
//                cell = [[MainLogInHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HEADER_CELL];
//                [(MainLogInHeaderCell *)cell setDelegate:self];
//            }else{
            cell = [[MainLogOutHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HEADER_CELL];
                [(MainLogOutHeaderCell *)cell setDelegate:self];
//            }
        }
    }else if (indexPath.row == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:SECOND_CELL];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SECOND_CELL];
            SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 160) imageURLStringsGroup:self.imgArr];
            cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
            cycleView.placeholderImage = [UIImage imageNamed:@"notice_place_holder"];
            cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
            
            [cell.contentView addSubview:cycleView];
        }
    }else if (indexPath.row == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:SERVICE_CELL];
        if (!cell) {
            cell = [[MainServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SERVICE_CELL];
            [(MainServiceCell *)cell setDelegate:self];
        }
    }else if (indexPath.row == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:SCROLL_CELL];
        if (!cell) {
            cell = [[MainScrollinfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SCROLL_CELL];
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:THIRD_CELL];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:THIRD_CELL];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
            imgView.image = [UIImage imageNamed:@"mainPage"];
            [cell.contentView addSubview:imgView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 240.0f;
    }else if (indexPath.row == 1){
        return 160.0f;
    }else if (indexPath.row == 2){
        CGFloat IconWidth = (kScreenWidth - 160) / 4;
        return IconWidth + 40;
    }
    else if (indexPath.row == 3){
        return 40.0f;
    }
    
    return 150;
}

#pragma mark MainHeaderViewCellDelegate
- (void)avatarImgPressed
{
    PersonalController *personVC = [[PersonalController alloc] init];
    [self.navigationController pushViewController:personVC animated:YES];
}

- (void)loginBtnPressed
{
    HYQLoginController *loginVC = [[HYQLoginController alloc] init];
    loginVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:loginVC animated:YES completion:^(void){}];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[NAVIBAR_GREEN_COLOR colorWithAlphaComponent:alpha]];
        self.navigationItem.titleView.hidden = NO;
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[NAVIBAR_GREEN_COLOR colorWithAlphaComponent:0]];
        self.navigationItem.titleView.hidden = YES;
    }
}

#pragma mark MainServiceDelegate
- (void)iconBtnTouchWithTag:(NSInteger)tag
{
    switch (tag){
            case 0:{
                ExcellentFinantialController *finanVC = [[ExcellentFinantialController alloc] init];
                [self.navigationController pushViewController:finanVC animated:YES];
            }
                break;

            case 1:{
                ExcellentBaseController *baseVC = [[ExcellentBaseController alloc] init];
                [self.navigationController pushViewController:baseVC animated:YES];
            }
                break;
                
            case 2:{
                ExcellentCampController *campVC = [[ExcellentCampController alloc] init];
                [self.navigationController pushViewController:campVC animated:YES];
            }
                break;
                
            case 3:{
                ExcellentOpenDayController *openVC = [[ExcellentOpenDayController alloc] init];
                [self.navigationController pushViewController:openVC animated:YES];
            }
                break;
                
            default:
                break;
    }
}

- (BOOL)validateCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
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