//
//  HYQEditController.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/1.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQEditController.h"
#import "UIImageView+WebCache.h"
#import "HYQUserManager.h"
#import "DownSheet.h"
#import "ReplaceAvartarResponse.h"
#import "ReplaceUidResponse.h"
#import "HYQReplaceNickController.h"
#import "HYQReplaceCodeController.h"

@interface HYQEditController ()
<
    DownSheetDelegate,
    ReplaceAvartarResponseDelegate,
    ReplaceUidResponseDelegate
>

@property (nonatomic, retain) UIImagePickerController *pickerVC;
@property (nonatomic, retain) UIImagePickerController *cameraVC;
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UIView        *emptyView;
@property (nonatomic, strong) UIView        *badNetView;
@property (nonatomic, retain) NSArray       *sheetArr;
@property (nonatomic, copy)   NSString      *useranme;
@property (nonatomic, copy)   NSString      *avatarUrl;

@end

@implementation HYQEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(replaceNickNameSucceed) name:@"replaceNickName" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"replaceNickName" object:nil];
}

- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = BG_GRAY_COLOR;
    [self.view addSubview:_tableView];
    
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    headerview.backgroundColor = BG_GRAY_COLOR;
    self.tableView.tableHeaderView = headerview;
}

- (NSArray *)sheetArr
{
    if (!_sheetArr) {
        DownSheetModel *Model_1 = [[DownSheetModel alloc]init];
        Model_1.title = @"拍照";
        
        DownSheetModel *Model_2 = [[DownSheetModel alloc]init];
        Model_2.title = @"从手机相册中选择";
        
        DownSheetModel *Model_3 = [[DownSheetModel alloc]init];
        Model_3.title = @"取消";
        
        _sheetArr = [NSArray arrayWithObjects:Model_1,Model_2,Model_3, nil];
    }
    
    return _sheetArr;
}

- (NSString *)useranme
{
    if (!_useranme) {
        _useranme = [[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"username"];
    }
    
    return _useranme;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *EDIT_CELL = @"edit_cell";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:EDIT_CELL];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EDIT_CELL];
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row == 0) {
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, 120, 30)];
        titleLbl.font = [UIFont systemFontOfSize:15.0f];
        titleLbl.textColor = [UIColor blackColor];
        titleLbl.text = @"修改头像";
        [cell.contentView addSubview:titleLbl];
        
        UIImageView *avartar = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 90, 15, 50, 50)];
        avartar.layer.cornerRadius = CGRectGetWidth(avartar.frame) / 2;
        avartar.clipsToBounds = YES;
        NSString *avatarStr = [[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"avatarUrl"];
        [avartar sd_setImageWithURL:[NSURL URLWithString:avatarStr] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
        
        [cell.contentView addSubview:avartar];
        
        UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, kScreenWidth - 40, 0.5)];
        lineLbl.backgroundColor = BG_GRAY_COLOR;
        [cell.contentView addSubview:lineLbl];
    }else if (indexPath.row == 1){
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 120, 30)];
        titleLbl.font = [UIFont systemFontOfSize:15.0f];
        titleLbl.textColor = [UIColor blackColor];
        titleLbl.text = @"修改昵称";
        [cell.contentView addSubview:titleLbl];
        
        UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 150, 15, 120, 30)];
        nameLbl.textAlignment = NSTextAlignmentRight;
        nameLbl.font = [UIFont systemFontOfSize:15.0f];
        nameLbl.textColor = [UIColor grayColor];
        nameLbl.text = [[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"username"];
        [cell.contentView addSubview:nameLbl];
        
        UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, kScreenWidth - 40, 0.5)];
        lineLbl.backgroundColor = BG_GRAY_COLOR;
        [cell.contentView addSubview:lineLbl];
    }else if(indexPath.row == 2){
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 120, 30)];
        titleLbl.font = [UIFont systemFontOfSize:15.0f];
        titleLbl.textColor = [UIColor blackColor];
        titleLbl.text = @"修改密码";
        [cell.contentView addSubview:titleLbl];
        
        UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 150, 15, 120, 30)];
        nameLbl.textAlignment = NSTextAlignmentRight;
        nameLbl.font = [UIFont systemFontOfSize:15.0f];
        nameLbl.textColor = [UIColor grayColor];
        nameLbl.text = @"点击修改";
        [cell.contentView addSubview:nameLbl];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80.5f;
    }else if(indexPath.row == 1){
        return 60.5f;
    }
    return 60.0f;
}

#pragma mark UITableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self avatarBtnPressed];
    }else if (indexPath.row == 1){
        HYQReplaceNickController *replaceVC = [[HYQReplaceNickController alloc] init];
        [self.navigationController pushViewController:replaceVC animated:YES];
    }else if (indexPath.row == 2){
        HYQReplaceCodeController *codeVC = [[HYQReplaceCodeController alloc] init];
        [self.navigationController pushViewController:codeVC animated:YES];
    }
}

- (void)avatarBtnPressed
{
    DownSheet *sheet = [[DownSheet alloc]initWithlist:self.sheetArr height:0];
    sheet.delegate = self;
    [sheet showInView:nil];
}

#pragma mark DownSheetDelegate
-(void)didSelectIndex:(NSInteger)index
{
    if (index == 0) {
        [self.navigationController presentViewController:self.cameraVC animated:YES completion:^(void){}];
    }
    
    if (index == 1) {
        [self.navigationController presentViewController:self.pickerVC animated:YES completion:^(void){}];
    }
}

- (UIImagePickerController *)pickerVC
{
    if (!_pickerVC) {
        _pickerVC = [[UIImagePickerController alloc]init];
        _pickerVC.view.backgroundColor = [UIColor orangeColor];
        _pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _pickerVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _pickerVC.delegate = self;
    }
    
    return _pickerVC;
}

- (UIImagePickerController *)cameraVC
{
    if (!_cameraVC) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            _cameraVC = [[UIImagePickerController alloc]init];
            _cameraVC.view.backgroundColor = [UIColor orangeColor];
            _cameraVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            _cameraVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            _cameraVC.delegate = self;
        }
    }
    
    return _cameraVC;
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
    UIImage *upImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self showNoTextStateHud];
        self.stateHud.detailsLabelText = @"图片上传中";
        [self uploadImageOperationWithImage:upImage];
        
        if (picker == self.pickerVC) {
            [self.pickerVC dismissViewControllerAnimated:YES completion:^(void){}];
        }
        
        if (picker == self.cameraVC) {
            [self.cameraVC dismissViewControllerAnimated:YES completion:^(void){}];
        }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (picker == self.pickerVC) {
        [self.pickerVC dismissViewControllerAnimated:YES completion:^(void){}];
    }
    
    if (picker == self.cameraVC) {
        [self.cameraVC dismissViewControllerAnimated:YES completion:^(void){}];
    }
}

- (void)uploadImageOperationWithImage:(UIImage *)image
{
    ReplaceAvartarResponse *response = [[ReplaceAvartarResponse alloc] initWith:image];
    response.delegate = self;
    [response start];
}

#pragma mark ReplaceAvartarResponseDelegate
- (void)replaceAvatarSucceedWithUrl:(NSString *)url
{
    _avatarUrl = url;
    [self uploadUidAvatarOperation];
}

- (void)uploadUidAvatarOperation
{
    ReplaceUidResponse *response = [[ReplaceUidResponse alloc] initWithUrl:_avatarUrl];
    response.delegate = self;
    [response start];
}

#pragma mark ReplaceUidResponseDelegate
- (void)replaceImageSucceed
{
    NSDictionary *dic = [[HYQUserManager sharedUserManager] userInfo];
    NSMutableDictionary *newDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [newDic removeObjectForKey:@"avatarUrl"];
    [newDic setObject:_avatarUrl forKey:@"avatarUrl"];
    [[HYQUserManager sharedUserManager] updateUserInfo:newDic];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"replaceAvatar" object:nil];
    
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    });
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self performSelectorOnMainThread:@selector(showStateHudWithText:) withObject:@"上传失败" waitUntilDone:YES];
}

//-------------------NOTIFICATION
- (void)replaceNickNameSucceed
{
    [self stopStateHud];
    _useranme = [[[HYQUserManager sharedUserManager] userInfo] objectForKey:@"username"];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end