//
//  MyAddressEditController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyAddressEditController.h"
#import "MyAddressPickController.h"
#import "HYQUserManager.h"
#import "MyAddressCorrectResponse.h"
#import "MyAddressDeleteResponse.h"
#import "DistrictModel.h"

@interface MyAddressEditController ()
<
    MyAddressCorrectResponseDelegate,
    MyAddressPickControllerDelegate,
    MyAddressDeleteResponse
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *enterField;      //企业名
@property (nonatomic, strong) UITextField *nameField;       //姓名
@property (nonatomic, strong) UITextField *phoneField;      //电话
@property (nonatomic, strong) UITextField *detailField;     //详细地址
@property (nonatomic, strong) UILabel     *locationLbl;     //地址
@property (nonatomic, copy)   NSString     *location;       //区
@property (nonatomic, copy)   NSString     *distritCode;
@property (nonatomic, assign) DistrictModel *district;      //区模型
@property (nonatomic, strong) AddressModel *address;

@end

@implementation MyAddressEditController
- (id)initWithAddressModel:(AddressModel *)address
{
    if (self = [super init]) {
        _address = address;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"新增地址";
    _location = _address.district;
    [self createUI];
}

- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = BG_GRAY_COLOR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    
    UIButton *toolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    toolBtn.frame = CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49);
    [toolBtn setBackgroundColor:NAVIBAR_GREEN_COLOR];
    [toolBtn setTitle:@"保存" forState:UIControlStateNormal];
    [toolBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [toolBtn addTarget:self action:@selector(checkUploadInformation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toolBtn];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    header.backgroundColor = BG_GRAY_COLOR;
    self.tableView.tableHeaderView = header;
    
    UIBarButtonItem *deleteBtn = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deleeteBtnPressed)];
    [self.navigationItem setRightBarButtonItem:deleteBtn];
}

//删除按钮入口
- (void)deleeteBtnPressed
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 10;
    [alert show];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10) {
        if (buttonIndex == 1) {
            [self deleteAddressOperation];
        }
    }
}

- (void)deleteAddressOperation
{
    [self showNoTextStateHud];
    MyAddressDeleteResponse *response = [[MyAddressDeleteResponse alloc] initWithAid:[_address.aid integerValue]];
    response.delegate = self;
    [response start];
}

- (void)checkUploadInformation
{
    if ([_enterField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"公司名未填！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if([_nameField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"姓名未填！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if ([_phoneField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号未填！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if ([_locationLbl.text isEqualToString:@"选择地址"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"区域未选择！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if([_detailField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"详细地址未填未填！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [self uploadNewAddressOperation];
    }
}


- (void)uploadNewAddressOperation
{
    [self showNoTextStateHud];
    MyAddressCorrectResponse *response = [[MyAddressCorrectResponse alloc] initWithEnterprise:_enterField.text
                                                                                  andWithName:_nameField.text
                                                                                 andWithPhone:_phoneField.text
                                                                               andWithAddress:_detailField.text
                                                                              andWithProvince:@"浙江"
                                                                                      andCity:@"杭州"
                                                                                     andState:_distritCode
                                                                                    andTacity:1
                                                                                   andWithAid:[_address.aid stringValue]];
    response.delegate = self;
    [response start];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ADD_CELL = @"add_cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:ADD_CELL];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ADD_CELL];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                if (!_enterField) {
                    _enterField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 40, 60)];
                    _enterField.font = [UIFont systemFontOfSize:13.0f];
                    _enterField.textColor = [UIColor blackColor];
                    _enterField.placeholder = @"输入公司名";
                    _enterField.text = _address.companyName;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell.contentView addSubview:_enterField];
                }
                
                UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, kScreenWidth - 40, 0.5)];
                lineLbl.backgroundColor = BG_GRAY_COLOR;
                [cell.contentView addSubview:lineLbl];
            }
                break;
                
            case 1:
            {
                if (!_nameField) {
                    _nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 40, 60)];
                    _nameField.font = [UIFont systemFontOfSize:13.0f];
                    _nameField.textColor = [UIColor blackColor];
                    _nameField.placeholder = @"输入联系人姓名";
                    _nameField.text = _address.linkman;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell.contentView addSubview:_nameField];
                }
                
                UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, kScreenWidth - 40, 0.5)];
                lineLbl.backgroundColor = BG_GRAY_COLOR;
                [cell.contentView addSubview:lineLbl];
            }
                break;
                
            case 2:
            {
                if (!_phoneField) {
                    _phoneField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 40, 60)];
                    _phoneField.font = [UIFont systemFontOfSize:13.0f];
                    _phoneField.textColor = [UIColor blackColor];
                    _phoneField.placeholder = @"输入电话";
                    _phoneField.text = [_address.linkPhone stringValue];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell.contentView addSubview:_phoneField];
                }
                
                UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, kScreenWidth - 40, 0.5)];
                lineLbl.backgroundColor = BG_GRAY_COLOR;
                [cell.contentView addSubview:lineLbl];
            }
                break;
                
            case 3:
            {
                if (!_locationLbl) {
                    _locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 40, 60)];
                    _locationLbl.font = [UIFont systemFontOfSize:13.0f];
                    _locationLbl.textColor = [UIColor blackColor];
                    [cell.contentView addSubview:_locationLbl];
                }
                if (![_location isEqualToString:@""]) {
                    _locationLbl.text = [NSString stringWithFormat:@"浙江省 杭州市 %@",_address.district];
                }else{
                    _locationLbl.text = @"选择地址";
                }
                
                
                UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, kScreenWidth - 40, 0.5)];
                lineLbl.backgroundColor = BG_GRAY_COLOR;
                [cell.contentView addSubview:lineLbl];
            }
                break;
                
            case 4:
            {
                if (!_detailField) {
                    _detailField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 40, 60)];
                    _detailField.font = [UIFont systemFontOfSize:13.0f];
                    _detailField.textColor = [UIColor blackColor];
                    _detailField.placeholder = @"输入详细地址";
                    _detailField.text = _address.address;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [cell.contentView addSubview:_detailField];
                }
            }
                break;
                
            default:
                break;
        }
    }else if (indexPath.section == 1){
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 100, 60)];
        lbl.font = [UIFont systemFontOfSize:13.0f];
        lbl.textColor = [UIColor blackColor];
        lbl.text = @"设置为默认地址";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:lbl];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            MyAddressPickController *pickView = [[MyAddressPickController alloc] init];
            pickView.delegate = self;
            [self.navigationController pushViewController:pickView animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.5f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        view.backgroundColor = BG_GRAY_COLOR;
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 30.0f;
    }
    
    return 0;
}

#pragma mark MyAddressPickControllerDelegate
- (void)finishPickAddressWith:(DistrictModel *)model
{
    _location = model.location;
    _distritCode = [model.locationID stringValue];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark MyAddressCorrectResponseDelegate
- (void)correctSucceed
{
    [self stopStateHud];
    [self performSelectorOnMainThread:@selector(showStateHudWithText:) withObject:@"添加地址成功！" waitUntilDone:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(correctAddressSucceedWith:)]) {
        AddressModel *model = [[AddressModel alloc] init];
        model.district = _location;
        model.linkman = _nameField.text;
        model.linkPhone = [NSNumber numberWithInteger:[_phoneField.text integerValue]];
        model.address = _detailField.text;
        model.province = @"浙江";
        model.city = @"杭州";
        model.districtCode = _distritCode;
        model.companyName = _enterField.text;
        [self.delegate correctAddressSucceedWith:model];
        [self dissmisssSelf];
    }
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self showNoTextStateHud];
    [self showStateHudWithText:text];
}

#pragma mark MyAddressDeleteResponse
- (void)deleteSucceed
{
    [self stopStateHud];
    [self performSelectorOnMainThread:@selector(showStateHudWithText:) withObject:@"删除成功" waitUntilDone:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAddressSucceed)]) {
        [self.delegate deleteAddressSucceed];
    }
    
    [self dissmisssSelf];
}

//-------------------
- (void)dissmisssSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end