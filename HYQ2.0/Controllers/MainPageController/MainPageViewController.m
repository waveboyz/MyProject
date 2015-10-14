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
#import "UINavigationBar+Awesome.h"
//------------------------------
#import "MainLogOutHeaderCell.h"
#import "MainLogInHeaderCell.h"
#import "MainServiceCell.h"
#import "MainScrollinfoCell.h"
#import "MainBannerCell.h"
#import "MainProductCell.h"
//----------------------------
#import "ExcellentBaseController.h"
#import "ExcellentCampController.h"
#import "ExcellentFinantialController.h"
#import "ExcellentOpenDayController.h"
//-----------------------------
#import "scanCameraController.h"
#import "HYQLoginController.h"
#import "PersonalController.h"
#import "HYQBaseWebController.h"
#import "InfoWebViewController.h"
#import "ServiceDetailController.h"
//----------------------------
#import "ServiceModel.h"
#import "ActivityModel.h"
#import "HYQMainResponse.h"
#import "HYQInterfaceMethod.h"
#import "QRBlurView.h"
#import "MJRefresh.h"
#define NAVBAR_CHANGE_POINT 50

@interface MainPageController ()
<
    MainLogOutHeaderCellDelegate,
    MainLogInHeaderCellDelegate,

    MainServiceCellDelegate,
    HYQmainResponseDelegate,
    MainScrollinfoCellDelegate,
    NSURLConnectionDelegate,
    MainBannerCellDelegate
>

@property (nonatomic, strong) UITableView   *tableview;
@property (nonatomic, strong) UIImageView   *buttonImg;             //navigationbar 头像
@property (nonatomic, strong) UIButton      *imgBtn;                //navigationbar 头像按钮
@property (nonatomic, strong) UIView        *emptyView;
@property (nonatomic, strong) UIView        *bgview;
@property (nonatomic, retain) NSMutableArray       *inforArr;              //资讯数组
@property (nonatomic, retain) NSMutableArray       *imgArr;                //banner数组
@property (nonatomic, retain) NSMutableArray       *productArr;            //商品数组
@property (nonatomic, strong) NSMutableData *receiveData;
@property (nonatomic, strong) QRBlurView    *blurview;
@property (nonatomic, assign) NSUInteger    currentpage;
@end

@implementation MainPageController

- (id)init
{
    if (self = [super init]) {
        _inforArr = [NSMutableArray new];
        _imgArr = [NSMutableArray new];
        _productArr = [NSMutableArray new];
        _currentpage = 1;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BG_GRAY_COLOR;
    [self createUI];
    [self getresponseOperation];
}

//获取首页信息请求
- (void)getresponseOperation
{
    [self showNoTextStateHud];
    HYQMainResponse *response = [[HYQMainResponse alloc] initWithPagesize:_currentpage];
    response.delegate = self;
    [response start];
}

#pragma mark HYQResponseDelegate
- (void)getMainInformationSucceedWithImgArr:(NSArray *)imgArr andWithProducts:(NSArray *)products andWithInfo:(NSArray *)information
{
    _imgArr = [NSMutableArray arrayWithArray:imgArr];
    _productArr = [NSMutableArray arrayWithArray:products];
    _inforArr = [NSMutableArray arrayWithArray:information];
    [self stopStateHud];
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self.tableview reloadData];
    });
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self showStateHudWithText:text];
}

- (void)noDataArr
{
    [self stopStateHud];
    [self.tableview.footer endRefreshing];
    _currentpage -= 1;
    [self showStateHudWithText:@"没有更多数据~"];
}

- (void)getMoreProducts:(NSArray *)products
{
    [self stopStateHud];
    [self.tableview.footer endRefreshing];
    [_productArr addObjectsFromArray:products];
    [self.tableview reloadData];
}

//----------
- (void)createUI
{
    //二维码扫描入口
    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"scan_icon"]
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(showScanPressed)];

    //显示二维码
    UIBarButtonItem *rightBtn2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"QRIcon"]
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(showQRcodePressed)];
    self.navigationItem.rightBarButtonItems = @[rightBtn1,rightBtn2];
    
    _imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 38)];
    _buttonImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    _buttonImg.layer.cornerRadius = CGRectGetWidth(_buttonImg.frame) / 2;
    _buttonImg.clipsToBounds = YES;
    [_imgBtn addSubview:_buttonImg];
    [_imgBtn addTarget:self action:@selector(titleViewPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setTitleView:_imgBtn];
    [self setButton];
    //-------------------------------------------
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight + 64) style:UITableViewStylePlain];
    self.tableview.backgroundColor = GRAY_COLOR;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableview];
    [self.view bringSubviewToFront:self.tableview];
    
    MJRefreshBackNormalFooter *footerView = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footerView setTitle:@"上拉获取更多~" forState:MJRefreshStateIdle];
    [footerView setTitle:@"松开刷新~" forState:MJRefreshStatePulling];
    [footerView setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    self.tableview.footer = footerView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableview.delegate = self;
    [self scrollViewDidScroll:self.tableview];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin) name:@"didLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin) name:@"didLogout" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin) name:@"replaceAvatar" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableview.delegate = nil;
    //使navigationbar还原
    [self.navigationController.navigationBar lt_reset];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"didLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin) name:@"didLogout" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"didLogout" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"replaceAvatar" object:nil];
    
}

- (void)loadMoreData
{
    _currentpage += 1;
    [self getresponseOperation];
}

//显示个人二维码
- (void)showQRcodePressed
{
    if ([[HYQUserManager sharedUserManager] isLogin]) {
        [self generateQRView];
    }else{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"用户未登录~"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
        [alert show];
    }
}

//生成二维码View
- (void)generateQRView
{
    _blurview = [[QRBlurView alloc] initWithFrame:CGRectMake(20, 50, kScreenWidth - 40,kScreenHeight - 130)];
    _blurview.backgroundColor = [UIColor whiteColor];
    _blurview.layer.cornerRadius = 7.5;
    _blurview.alpha = 0.f;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
    tapGR.numberOfTapsRequired = 1;
    [_blurview addGestureRecognizer:tapGR];
    _blurview.userInteractionEnabled = YES;
    [self creatMaskBgViewWithContentView:_blurview];
}

- (void)creatMaskBgViewWithContentView:(UIView *)contentView
{
    if (!_bgview)
    {
        _bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [_bgview setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        _bgview.backgroundColor = [UIColor grayColor];
        _bgview.alpha = 0.5f;
        [self.view.superview.superview addSubview:_bgview];
        [self.view.superview.superview.superview addSubview:contentView];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
        tapGR.numberOfTapsRequired = 1;
        [_bgview addGestureRecognizer:tapGR];
        _bgview.userInteractionEnabled = YES;
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        contentView.alpha = 1.0f;
        _bgview.alpha = 0.8f;
    } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.1 animations:^{ }];
     }];
}

//隐藏二维码View
- (void)hideView
{
    [UIView animateWithDuration:0.3 animations:^{
        _blurview.alpha = 0.f;
        _bgview.alpha = 0.f;
    } completion:^(BOOL finished)
     {
         self.view.superview.userInteractionEnabled = YES;
         [self removeMaskandBlur];
     }];
}

//移除二维码View
- (void)removeMaskandBlur
{
    [_blurview removeFromSuperview];
    [_bgview removeFromSuperview];
    _blurview = nil;
    _bgview = nil;
}

//扫描二维码入口
- (void)showScanPressed
{
    if ([self validateCamera]) {
        ScanCameraController *scanVC = [[ScanCameraController alloc] init];
        [self.navigationController pushViewController:scanVC animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"此设备不具备扫码功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

//检测设备是否具有扫描功能
- (BOOL)validateCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

//设置titleView
- (void)setButton
{
    if ([[HYQUserManager sharedUserManager] isLogin]) {
        _buttonImg.image = nil;
        [_buttonImg sd_setImageWithURL:[NSURL URLWithString:[[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"avatarUrl"]] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    }else{
        _buttonImg.image = [UIImage imageNamed:@"avatar_placeholder"];
    }
}

- (void)titleViewPressed
{
    if ([[HYQUserManager sharedUserManager] isLogin]) {
        [self avatarImgPressed];
    }else{
        [self loginBtnPressed];
    }
}


#pragma mark NSNotificationCenter
- (void)userDidLogin
{
    [self setButton];
    [self.tableview reloadData];
}

//加载空视图
- (UIView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _emptyView.backgroundColor = GRAY_COLOR;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWidth * 0.5 - 80, kScreenHeight * 0.5 - 40, 160, 80);
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(getresponseOperation) forControlEvents:UIControlEventTouchUpInside];
        [_emptyView addSubview:btn];
    }
    
    return _emptyView;
}

#pragma mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _productArr.count + 4;
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
            if ([[HYQUserManager sharedUserManager] isLogin]) {
                cell = [[MainLogInHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HEADER_CELL];
                [(MainLogInHeaderCell *)cell setDelegate:self];
            }else{
            cell = [[MainLogOutHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HEADER_CELL];
                [(MainLogOutHeaderCell *)cell setDelegate:self];
            }
    }else if (indexPath.row == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:SECOND_CELL];
        if (!cell) {
            cell = [[MainBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SECOND_CELL];
            [(MainBannerCell *)cell setDelegate:self];
        }
        [(MainBannerCell *)cell setImgArr:_imgArr];
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
            [(MainScrollinfoCell *)cell setDelegate:self];
        }
        if (_inforArr.count > 0) {
                    [(MainScrollinfoCell *)cell setTitleArr:_inforArr];
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:THIRD_CELL];
        if (!cell) {
            cell = [[MainProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:THIRD_CELL];
        }
        [(MainProductCell *)cell setService:_productArr[indexPath.row - 4]];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 260.0;
    }else if (indexPath.row == 1){
        return 205.0;
    }else if (indexPath.row == 2){
        CGFloat IconWidth = (kScreenWidth - 160) / 4;
        return IconWidth + 40;
    }
    else if (indexPath.row == 3){
        return 40.0f;
    }
    
    return 235;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row >= 4) {
        ServiceDetailController *serVC = [[ServiceDetailController alloc] initWithServiceModel:_productArr[indexPath.row - 4]];
        serVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        UINavigationController * jackNavigationController = [[UINavigationController alloc] initWithRootViewController:serVC];
        [self presentViewController:jackNavigationController animated:YES completion:^(void){}];
    }
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

- (void)logoutAvatarImgPressed
{
    HYQLoginController *loginVC = [[HYQLoginController alloc] init];
    loginVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:loginVC animated:YES completion:^(void){}];
}

#pragma mark MainScrollinfoCellDelegate
- (void)infoCellTouchedWithUrl:(NSString *)url andWithTitle:(NSString *)title
{
    InfoWebViewController *webView = [[InfoWebViewController alloc] initWithUrl:url andTitle:title];
    [self presentViewController:webView animated:YES completion:^(void){}];
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
                HYQBaseWebController *finanVC = [[HYQBaseWebController alloc] initWithUrl:EXCELLENT_FINANTIAL_INTERFACE andWithTitle:@"优创金融方案"];
//                ExcellentFinantialController *finanVC = [[ExcellentFinantialController alloc] init];
                [self.navigationController pushViewController:finanVC animated:YES];
            }
                break;

            case 1:{
                HYQBaseWebController *baseVC = [[HYQBaseWebController alloc] initWithUrl:EXCELLENT_BASE_INTERFACE andWithTitle:@"优创基地"];
//                ExcellentBaseController *baseVC = [[ExcellentBaseController alloc] init];
                [self.navigationController pushViewController:baseVC animated:YES];
            }
                break;
                
            case 2:{
                HYQBaseWebController *campVC = [[HYQBaseWebController alloc] initWithUrl:EXCELLENT_CAMP_INTERFACE andWithTitle:@"优创基地"];
//                ExcellentCampController *campVC = [[ExcellentCampController alloc] init];
                [self.navigationController pushViewController:campVC animated:YES];
            }
                break;
                
            case 3:{
                HYQBaseWebController *openVC = [[HYQBaseWebController alloc] initWithUrl:EXCELLENT_OPEN_INTERFACE andWithTitle:@"优创开放日"];
//                ExcellentOpenDayController *openVC = [[ExcellentOpenDayController alloc] init];
                [self.navigationController pushViewController:openVC animated:YES];
            }
                break;
                
            default:
                break;
    }
}

#pragma mark MainBannerCellDelegate
- (void)didSelectedBannerWithUrl:(NSString *)url
{
    InfoWebViewController *webView = [[InfoWebViewController alloc] initWithUrl:url andTitle:nil];
    [self presentViewController:webView animated:YES completion:^(void){}];
}

@end