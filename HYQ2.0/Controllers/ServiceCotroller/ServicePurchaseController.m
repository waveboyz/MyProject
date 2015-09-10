//
//  ServicePurchaseController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServicePurchaseController.h"
#import "ServiceAddressPickController.h"
#import "PurchaseHeaderCell.h"
#import "PurchaseSecondCell.h"
#import "MyAddressResponse.h"
#import "AddressModel.h"
#import <AlipaySDK/AlipaySDK.h>

@interface ServicePurchaseController ()
<
    MyAddressResponseDelegate,
    PurchaseSecondCellDelegate
>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView      *toolView;        //工具条
@property (nonatomic, retain) NSMutableArray *addArr;       //地址数组
@property (nonatomic, strong) UILabel     *desLbl;          //价格描述
@property (nonatomic, strong) UILabel     *priceLbl;        //工具条总价格label
@property (nonatomic, assign) NSUInteger    price;          //产品单价

@end

@implementation ServicePurchaseController

- (id)initWithService:(ServiceModel *)service
{
    if (self = [super init]) {
        _service = service;
        _addArr = [NSMutableArray new];
    }
    
    return self;
}

- (void)viewDidLoad {
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

- (void)createUI
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = GRAY_COLOR;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableview];
    
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
    _toolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_toolView];
    
    UIButton *purchaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    purchaseBtn.backgroundColor = NAVIBAR_GREEN_COLOR;
    purchaseBtn.frame = CGRectMake(kScreenWidth - 120, 0, 120, 49);
    [purchaseBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [purchaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_toolView addSubview:purchaseBtn];
    
    _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 80, 0, 60, 49)];
    _desLbl.font = [UIFont systemFontOfSize:18.0];
    _desLbl.textAlignment = NSTextAlignmentRight;
    _desLbl.text = @"实付：";
    [_toolView addSubview:_desLbl];
    
    _priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 20, 0, 120, 49)];
    _priceLbl.font = [UIFont systemFontOfSize:18.0];
    _priceLbl.textColor = [UIColor redColor];
    _price = [_service.price integerValue];
    _priceLbl.text = [NSString stringWithFormat:@"￥%ld",_price];
    [_toolView addSubview:_priceLbl];
}

#pragma mark MyAddressResponseDelegate
- (void)getAddressArrayWith:(NSMutableArray *)array
{
    _addArr = array;
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        [self createUI];
    });
}

- (void)wrongOperationWithText:(NSString *)text
{

}

- (void)noDataArr
{
    
}

#pragma mark PurchaseSecondCellDelegate
- (void)mathBtnPressedWithCount:(NSUInteger)count
{
    _priceLbl.text = [NSString stringWithFormat:@"￥%ld",_price * count];
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
        
        [(PurchaseHeaderCell *)cell setAddress:self.addArr[0]];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:PURCHASE_SECOND];
        if (!cell) {
            cell = [[PurchaseSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PURCHASE_SECOND];
        }
        [(PurchaseSecondCell *)cell setDelegate:self];
        [(PurchaseSecondCell *)cell setService:_service];
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

@end