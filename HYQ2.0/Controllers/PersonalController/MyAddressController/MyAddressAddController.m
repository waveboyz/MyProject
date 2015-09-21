//
//  MyAddressAddController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/1.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyAddressAddController.h"
#import "MyAddressPickController.h"
#import "HYQUserManager.h"
#import "MyAddressCorrectResponse.h"
#import "DistrictModel.h"

@interface MyAddressAddController ()
<
    MyAddressCorrectResponseDelegate,
    MyAddressPickControllerDelegate
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *enterField;      //企业名
@property (nonatomic, strong) UITextField *nameField;       //姓名
@property (nonatomic, strong) UITextField *phoneField;      //电话
@property (nonatomic, strong) UITextField *detailField;     //详细地址
@property (nonatomic, strong) UISwitch    *if_default;
@property (nonatomic, strong) UILabel     *locationLbl;     //地址
@property (nonatomic, retain) NSString     *location;       //区
@property (nonatomic, retain) NSString     *distritCode;
@property (nonatomic, assign) DistrictModel *district;      //区模型

@end

@implementation MyAddressAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增地址";
//    _location = @"";
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

//上传新地址操作。其中把aid屏蔽掉
- (void)uploadNewAddressOperation
{
    [self showNoTextStateHud];
    NSNumber *is_default = [NSNumber numberWithBool:[_if_default isOn]];
    MyAddressCorrectResponse *response = [[MyAddressCorrectResponse alloc] initWithEnterprise:_enterField.text
                                                                                  andWithName:_nameField.text
                                                                                 andWithPhone:_phoneField.text
                                                                               andWithAddress:_detailField.text
                                                                              andWithProvince:@"浙江"
                                                                                      andCity:@"杭州"
                                                                                     andState:_distritCode
                                                                                    andTacity:is_default
                                                                                      andWithAid:nil];
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
                    _enterField.placeholder = @"输入企业名称";
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
                    _nameField.placeholder = @"输入姓名";
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
                    _phoneField.placeholder = @"输入联系电话";
                    _phoneField.text = [[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"phone"];
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
                }
                    [cell.contentView addSubview:_locationLbl];
//                if (![_location isEqualToString:@""]) {
//                    _locationLbl.text = [NSString stringWithFormat:@"浙江省 杭州市 %@",_location];
//                    NSLog(@"%@",_locationLbl.text);
//                }else{
//                    _locationLbl.text = @"选择地址";
//                }
                if (_location != nil) {
                    _locationLbl.text = [NSString stringWithFormat:@"浙江省 杭州市 %@",_location];
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
        
        if (!_if_default) {
            _if_default = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 15, 60, 64)];
            _if_default.on = NO;
            [cell.contentView addSubview:_if_default];
        }
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
    _location = nil;
    _location = model.location;
    _distritCode = [model.locationID stringValue];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark MyAddressCorrectResponseDelegate
- (void)correctSucceedWith:(NSNumber *)aid
{
    [self performSelectorOnMainThread:@selector(showStateHudWithText:) withObject:@"添加地址成功！" waitUntilDone:YES];
    [self dissmisssSelf];
    if (![self.delegate isEqual:[NSNull null]]&& [self.delegate respondsToSelector:@selector(addAddressSucceedWithAddress:)]) {
        AddressModel *model = [[AddressModel alloc] init];
        model.district = _location;
        model.linkman = _nameField.text;
        model.linkPhone = [NSNumber numberWithInteger:[_phoneField.text integerValue]];
        model.address = _detailField.text;
        model.province = @"浙江";
        model.city = @"杭州";
        model.districtCode = _distritCode;
        model.aid = aid;
        model.tacitiy = [_if_default isOn];
        [self.delegate addAddressSucceedWithAddress:model];
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(addAddressSucceed)]) {
        [self.delegate addAddressSucceed];
    }
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self showStateHudWithText:@"添加地址失败！"];
}

//-------------------
- (void)dissmisssSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end