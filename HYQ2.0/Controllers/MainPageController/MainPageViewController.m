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
#import "UINavigationBar+Awesome.h"
#import "MainHeaderViewCell.h"

#define NAVBAR_CHANGE_POINT 50

@interface MainPageController ()
<
    MainHeaderViewCellDelegate
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
    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"scanIcon"]
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
    UIButton *imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
    imgBtn.contentMode = UIViewContentModeScaleAspectFit;
    imgBtn.layer.cornerRadius = CGRectGetWidth(imgBtn.frame)/2;
    [imgBtn addTarget:self action:@selector(avatarImgPressed) forControlEvents:UIControlEventTouchUpInside];
    [imgBtn sd_setImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    [self.navigationItem setTitleView:imgBtn];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableview.backgroundColor = GRAY_COLOR;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableview.delegate = self;
    [self scrollViewDidScroll:self.tableview];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableview.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
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
    static NSString *THIRD_CELL = @"third_cell";
    
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:HEADER_CELL];
        if (!cell) {
            cell = [[MainHeaderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HEADER_CELL];
            [(MainHeaderViewCell *)cell setDelegate:self];
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
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:THIRD_CELL];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:THIRD_CELL];
            cell.backgroundColor = ORANGE_COLOR;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 240;
    }else if (indexPath.row == 1){
        return 160;
    }
    
    return 100;
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