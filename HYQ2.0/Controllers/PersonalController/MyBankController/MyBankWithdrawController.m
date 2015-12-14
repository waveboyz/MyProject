//
//  MyBankWithdrawController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/16.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyBankWithdrawController.h"
#import "HYQUserManager.h"
#import "MyPaymentCell.h"
#import "HYQWithdrawResponse.h"
#import "MyBankWithDrawResponse.h"

@interface MyBankWithdrawController ()
<
    HYQWithdrawResponseDelegate,
    MyBankWithDrawResponseDelegate
>

@property (nonatomic, strong) UIView      *bgView;
@property (nonatomic, strong) UIView      *headerView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *cardField;
@property (nonatomic, strong) UITextField *cashField;
@property (nonatomic, strong) UIButton    *confirmBtn;
@property (nonatomic, assign) NSInteger    cashCount;

@end

@implementation MyBankWithdrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    [super createUI];
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 94, kScreenWidth, 224)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    //-----------------------------------------------
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 50)];
    lbl1.font = [UIFont systemFontOfSize:15.0f];
    lbl1.textColor = [UIColor blackColor];
    lbl1.text = @"账户提现";
    [_bgView addSubview:lbl1];
    
    _nameField = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, kScreenWidth -  150, 50)];
    _nameField.font = [UIFont systemFontOfSize:15.0f];
    _nameField.textColor = [UIColor blackColor];
    _nameField.placeholder = @"用户名（实名认证姓名）";
    [_bgView addSubview:_nameField];
    
    UILabel *lineLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, kScreenWidth - 30, 0.5)];
    lineLbl1.backgroundColor = LINE_COLOR;
    [_bgView addSubview:lineLbl1];
    //-----------------------------------------------
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50.5, 100, 50)];
    lbl2.font = [UIFont systemFontOfSize:15.0f];
    lbl2.textColor = [UIColor blackColor];
    lbl2.text = @"银行卡号";
    [_bgView addSubview:lbl2];
    
    _cardField = [[UITextField alloc] initWithFrame:CGRectMake(130, 50.5, kScreenWidth -  150, 50)];
    _cardField.font = [UIFont systemFontOfSize:15.0f];
    _cardField.textColor = [UIColor blackColor];
    _cardField.placeholder = @"输入您本人的银行卡号";
    _cardField.keyboardType = UIKeyboardTypePhonePad;
    [_bgView addSubview:_cardField];
    
    UILabel *lineLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 100.5, kScreenWidth - 30, 0.5)];
    lineLbl2.backgroundColor = LINE_COLOR;
    [_bgView addSubview:lineLbl2];
    //-----------------------------------------------
    UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 101, 100, 50)];
    lbl3.font = [UIFont systemFontOfSize:15.0f];
    lbl3.textColor = [UIColor blackColor];
    lbl3.text = @"提现金额";
    [_bgView addSubview:lbl3];
    
    NSDictionary *userDic = [[HYQUserManager sharedUserManager] userInfo];
    _cashField = [[UITextField alloc] initWithFrame:CGRectMake(130, 101, kScreenWidth -  150, 50)];
    _cashField.keyboardType = UIKeyboardTypePhonePad;
    _cashField.font = [UIFont systemFontOfSize:15.0f];
    _cashField.textColor = [UIColor blackColor];
    _cashField.placeholder = [NSString stringWithFormat:@"本次最多可提现%@元",[userDic objectForKey:@"property"]];
    [_bgView addSubview:_cashField];
    //---------------------------------------------
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(20, 161, kScreenWidth - 40, 50);
    [_confirmBtn addTarget:self action:@selector(confirmBtnPressed) forControlEvents:UIControlEventTouchDragInside];
    [_confirmBtn setBackgroundColor:NAVIBAR_GREEN_COLOR];
    [_confirmBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirmBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_confirmBtn];
    
    self.tableView.frame = CGRectMake(0, 254, kScreenWidth, kScreenHeight - 254);
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView.header beginRefreshing];
}

- (void)loadNewData
{
    [super loadNewData];
    [self getPaymentOperation];
}

- (void)loadMoreData
{
    [super loadMoreData];
    [self getPaymentOperation];
}

- (void)getPaymentOperation
{
    [self showNoTextStateHud];
    HYQWithdrawResponse *response = [[HYQWithdrawResponse alloc] initWithType:@"提现" andWithCurrentPage:self.currentPage];
    response.delegate = self;
    [response start];
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _headerView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 50, 0, 100, 40)];
        titleLbl.text = @"提现";
        titleLbl.textAlignment = NSTextAlignmentCenter;
        titleLbl.textColor = NAVIBAR_GREEN_COLOR;
        titleLbl.font = [UIFont systemFontOfSize:13.0f];
        titleLbl.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:titleLbl];
    }
    
    return _headerView;
}

#pragma mark HYQWithdrawResponseDelegate
- (void)getInfoWith:(NSMutableArray *)infoArr
{
    if (self.currentPage == 1) {
        self.dataArr = infoArr;
    }else {
        [self.dataArr addObjectsFromArray:infoArr];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        if (self.currentPage == 1) {
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
            [self.view bringSubviewToFront:self.bgView];
        }else{
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];
            [self.view bringSubviewToFront:self.bgView];
        }
    });
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self showStateHudWithText:text];
    if (self.currentPage == 1) {
        [self.tableView.header endRefreshing];
    }else{
        [self.tableView.footer endRefreshing];
    }
}

- (void)noDataArr
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        [self showStateHudWithText:@"暂无更多数据~"];
        if (self.currentPage == 1) {
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
        }else{
            [self.tableView.footer endRefreshing];
            self.currentPage -=1;
        }
    });
}

//银行卡正则校验
- (BOOL) checkCardNo:(NSString*) cardNo
{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

//检验申请金额是否超过可提现金额
- (BOOL)checkCashCountCorrectWith:(NSString *)cash
{
    NSInteger count = [cash integerValue];
    NSDictionary *userDic = [[HYQUserManager sharedUserManager] userInfo];
    NSString *propertyStr = [userDic objectForKey:@"property"];
    NSInteger property = [propertyStr integerValue];
    
    if (count > property) {
        return YES;
    }else{
        return NO;
    }
}

- (void)confirmBtnPressed
{
    if ([_nameField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 200;
        [alert show];
    }else if ([_cardField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"银行卡不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 205;
        [alert show];
    }else if ([_cashField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"金额不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 210;
        [alert show];
    }else if (![self checkCardNo:_cardField.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"银行卡输入有误！！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 205;
        [alert show];
    }else if ([self  checkCashCountCorrectWith:_cashField.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"超过可提现金额！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 210;
        [alert show];
    }
}

- (void)bankWithDrawOperation
{

}

#pragma mark MyBankWithDrawResponseDelegate
- (void)withdrawSucceed
{

}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonInde
{
    if (alertView.tag == 200) {
        [_nameField becomeFirstResponder];
    }else if (alertView.tag == 205){
        [_cardField becomeFirstResponder];
    }else if (alertView.tag == 210){
        [_cashField becomeFirstResponder];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PAYMENT_CELL = @"payment_cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:PAYMENT_CELL];
    if (!cell) {
        cell = [[MyPaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PAYMENT_CELL];
    }
    [(MyPaymentCell *)cell setPayment:self.dataArr[indexPath.row]];
    
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60.5f;
}

@end