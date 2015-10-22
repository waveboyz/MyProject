//
//  ServicePurchaseController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServicePurchaseController.h"
#import "ServiceAddressPickController.h"
#import "InfoWebViewController.h"
#import "PurchaseHeaderCell.h"
#import "PurchaseSecondCell.h"
#import "AddressModel.h"
#import "Order.h"
#import "DataSigner.h"
#import "DownSheet.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ServicePayOrderResponse.h"
#import "AliPayCallBackResponse.h"
#import "MyAddressResponse.h"
#import "PaySucceedController.h"
#import "ProductModel.h"

@interface ServicePurchaseController ()
<
    MyAddressResponseDelegate,
    PurchaseSecondCellDelegate,
    ServiceAddressPickControllerDelegate,
    DownSheetDelegate,
    ServicePayOrderResponseDelegate,
    AliPayCallBackResponseDelegate
>

@property (nonatomic, strong) UITableView       *tableview;
@property (nonatomic, strong) UIView            *toolView;        //工具条
@property (nonatomic, strong) UIView            *payfooterView;     //购买协议
@property (nonatomic, retain) NSMutableArray    *addArr;       //地址数组
@property (nonatomic, retain) NSArray           *sheetArr;      //支付方式数组
@property (nonatomic, strong) UILabel           *desLbl;          //价格描述
@property (nonatomic, strong) UILabel           *priceLbl;        //工具条总价格label
@property (nonatomic, strong) UIButton          *agreeBtn;      //协议赞同按钮
@property (nonatomic, assign) NSUInteger        price;          //产品单价
@property (nonatomic, assign) NSUInteger        totalPrice;     //总付款
@property (nonatomic, assign) NSUInteger        paycount;
@property (nonatomic, retain) NSNumber          *tradeNo;       //订单号
@property (nonatomic, retain) NSNumber          *oid;
@property (nonatomic, strong) AddressModel      *addModel;

@end

@implementation ServicePurchaseController

- (id)initWithProduct:(ProductModel *)product
{
    if (self = [super init]) {
        _product = product;
        _price = [_product.price integerValue];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"确认订单";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = NAVIBAR_GREEN_COLOR;
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    [self getAddressOperation];
}

//获取地址列表请求
- (void)getAddressOperation
{
    [self showNoTextStateHud];
    MyAddressResponse *response = [[MyAddressResponse alloc] init];
    response.delegate = self;
    [response start];
}

//actionsheet列表
- (NSArray *)sheetArr
{
    if (!_sheetArr) {
        DownSheetModel *Model_1 = [[DownSheetModel alloc]init];
        Model_1.title = @"选择使用支付宝";
        Model_1.icon = @"aliIcon";
        DownSheetModel *Model_2 = [[DownSheetModel alloc]init];
        Model_2.title = @"取消";
        
        _sheetArr = [NSArray arrayWithObjects:Model_1,Model_2, nil];
    }
    
    return _sheetArr;
}

- (void)createUI
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = GRAY_COLOR;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.tableFooterView = self.payfooterView;
    _tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableview];
    
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
    _toolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_toolView];
    
    UIButton *purchaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    purchaseBtn.backgroundColor = NAVIBAR_GREEN_COLOR;
    purchaseBtn.frame = CGRectMake(kScreenWidth - 120, 0, 120, 49);
    [purchaseBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [purchaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [purchaseBtn addTarget:self action:@selector(purchaseBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:purchaseBtn];
    
    _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 80, 0, 60, 49)];
    _desLbl.font = [UIFont systemFontOfSize:18.0];
    _desLbl.textAlignment = NSTextAlignmentRight;
    _desLbl.text = @"实付：";
    [_toolView addSubview:_desLbl];
    
    _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 20, 0, 120, 49)];
    _priceLbl.font = [UIFont systemFontOfSize:18.0];
    _priceLbl.textColor = [UIColor redColor];
    _priceLbl.text = [NSString stringWithFormat:@"￥%ld",_price];
    [_toolView addSubview:_priceLbl];
}

- (void)purchaseBtnPressed
{
    if (!_agreeBtn.selected) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请先阅读购买协议，并勾选赞同"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else{
        DownSheet *sheet = [[DownSheet alloc]initWithlist:self.sheetArr height:0];
        sheet.delegate = self;
        [sheet showInView:self];
    }
}

//付款请求
- (void)payOperation
{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = PARTNER;
    order.seller = SELLER;
    order.tradeNO = [NSString stringWithFormat:@"%@",_tradeNo]; //订单ID（由商家自行制定）
    order.productName = _product.name; //商品标题
    order.productDescription = _product.contentText; //商品描述
    order.amount = [NSString stringWithFormat:@"%ld",_totalPrice]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"HYQ2.0";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    NSString *privateKey = PRIVATEKEY;
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
	id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            [self payStatusWithDic:resultDic];

        }];
    }
}

//支付宝支付结果返回
- (void)payStatusWithDic:(NSDictionary *)dic
{
    NSNumber *state = [dic objectForKey:@"resultStatus"];
    AliPayCallBackResponse *response = [[AliPayCallBackResponse alloc] initWithTradeNO:_tradeNo andWithTradeStatus:state andWithResult:[dic objectForKey:@"result"]];
    response.delegate = self;
    [response start];
}

//获得订单号
- (void)getPayOrderOperation
{
    [self showNoTextStateHud];
    ServicePayOrderResponse *response = [[ServicePayOrderResponse alloc] initWithPid:_product.pid
                                                                          andWithAid:_addModel.aid
                                                                         andWithOnum:[NSNumber numberWithInteger:_paycount]
                                                                   andWithTotalPrice:[NSNumber numberWithInteger:_totalPrice]
                                                                          andWithMsg:nil];
    response.delegate = self;
    [response start];
}

- (UIView *)payfooterView
{
    if (!_payfooterView) {
        _payfooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBtn.frame = CGRectMake(30, 0, 30, 40);
        _agreeBtn.selected = NO;
        [_agreeBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"onselect"] forState:UIControlStateSelected];
        [_agreeBtn addTarget:self action:@selector(changeAgreeBtn) forControlEvents:UIControlEventTouchUpInside];
        [_payfooterView addSubview:_agreeBtn];

        UILabel *deslbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 130, 40)];
        deslbl.textColor = [UIColor blackColor];
        deslbl.font = [UIFont systemFontOfSize:13.0f];
        deslbl.text = @"点击同意意味着您遵守";
        [_payfooterView addSubview:deslbl];
        
        UIButton *agreementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        agreementBtn.frame = CGRectMake(190, 0, 70, 40);
        agreementBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [agreementBtn addTarget:self action:@selector(showProtocalPressed) forControlEvents:UIControlEventTouchUpInside];
        [agreementBtn setTitle:@"好园区协议" forState:UIControlStateNormal];
        [agreementBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_payfooterView addSubview:agreementBtn];
    }
    
    return _payfooterView;
}

- (void)showProtocalPressed
{
    InfoWebViewController *webVC = [[InfoWebViewController alloc] initWithUrl:PUCHASE_AGREEMENT_URL andTitle:@"用户协议"];
    [self presentViewController:webVC animated:YES completion:^(void){}];
}

- (void)changeAgreeBtn
{
    _agreeBtn.selected = !_agreeBtn.selected;
}

#pragma mark MyAddressResponseDelegate
- (void)getAddressArrayWith:(NSMutableArray *)array
{
    _addArr = array;
    _addModel = _addArr[0];
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        [self createUI];
    });
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self showStateHudWithText:text];
}

- (void)noDataArr
{
    [self stopStateHud];
    [self createUI];
}

#pragma mark PurchaseSecondCellDelegate
- (void)mathBtnPressedWithCount:(NSUInteger)count
{
    _paycount = count;
    _totalPrice = _price * _paycount;
    _priceLbl.text = [NSString stringWithFormat:@"￥%ld",_totalPrice];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PURCHASE_HEADER = @"purchase_header";
    static NSString *PURCHASE_SECOND = @"purchase_second";
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:PURCHASE_HEADER];
        if (!cell) {
            cell = [[PurchaseHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PURCHASE_HEADER];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        [(PurchaseHeaderCell *)cell setAddress:_addModel];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:PURCHASE_SECOND];
        if (!cell) {
            cell = [[PurchaseSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PURCHASE_SECOND];
        }
        [(PurchaseSecondCell *)cell setDelegate:self];
        [(PurchaseSecondCell *)cell setProduct:_product];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90.5f;
    }
    
    return 370.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        ServiceAddressPickController *pickVC = [[ServiceAddressPickController alloc] init];
        pickVC.delegate = self;
        [self.navigationController pushViewController:pickVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 30.0f;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        footer.backgroundColor = BG_GRAY_COLOR;
        
        return footer;
    }

    return nil;
}

#pragma mark ServicePayOrderResponseDelegate
- (void)getPayOrderSucceedWithPayOrder:(NSNumber *)payorder andOid:(NSNumber *)oid
{
    _tradeNo = payorder;
    _oid = oid;
    [self payOperation];
}

#pragma mark ServiceAddressPickControllerDelegate
- (void)finishPickWithAddress:(AddressModel *)address
{
    _addModel = nil;
    _addModel = address;
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark AliPayCallBackResponseDelegate
- (void)getPayResult
{
    [self stopStateHud];
    PaySucceedController *succeedVC = [[PaySucceedController alloc] init];
    [self.navigationController pushViewController:succeedVC animated:YES];
}

#pragma mark DownSheetDelegate
-(void)didSelectIndex:(NSInteger)index
{
    if (index == 0) {
        [self getPayOrderOperation];
    }
}

@end