//
//  EditPersonFileControllerViewController.m
//  HYQ
//
//  Created by 周翔 on 15/6/17.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "EditPersonFileControllerViewController.h"
#import "EditHeaderCell.h"
@interface EditPersonFileControllerViewController ()
<
EditHeaderCellDelegate
>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIImagePickerController *pickerVC;
@property (nonatomic, retain) UIImagePickerController *cameraVC;
@property (nonatomic, strong) NSArray     *titleArr;

@end

@implementation EditPersonFileControllerViewController

- (id)init
{
    if (self = [super init]) {
        self.titleArr = @[@"昵称",@"手机",@"在职公司",@"所在园区",@"职务"];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = BG_GRAY_COLOR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.alwaysBounceVertical = NO;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(savePersonInfoOperation)];
    [self.navigationItem setRightBarButtonItem:rightBtn animated:YES];
    
    self.pickerVC = [[UIImagePickerController alloc]init];
    self.pickerVC.view.backgroundColor = [UIColor orangeColor];
    self.pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.pickerVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    self.pickerVC.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.cameraVC = [[UIImagePickerController alloc]init];
        self.cameraVC.view.backgroundColor = [UIColor orangeColor];
        self.cameraVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.cameraVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        self.cameraVC.delegate = self;
    }
    
    [self.view addSubview:_tableView];
}


- (void)savePersonInfoOperation
{

}

#pragma mark UITableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *EDIT_CELL = @"edit_cell";
    static NSString *HEAD_CELL = @"haed_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EDIT_CELL];
    if (!cell) {
        if (indexPath.row == 0) {
            cell = [[EditHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HEAD_CELL];
            [(EditHeaderCell *)cell setDelegate:self];
        }
        
        if (indexPath.row > 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EDIT_CELL];
            UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, kScreenWidth, 0.5)];
            lineLbl.backgroundColor = LINE_COLOR;
            [cell.contentView addSubview:lineLbl];
            cell.textLabel.text = self.titleArr[(indexPath.row) - 1];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 120;
    }
    if (indexPath.row >0) {
        return 40.5f;
    }
    
    return 0;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark EditHeaderCellDelegate
- (void)avatarBtnPressed
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"照片库",nil];
    
    [sheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController presentViewController:self.cameraVC animated:YES completion:^(void){}];
    }
    
    if (buttonIndex == 1) {
        [self.navigationController presentViewController:self.pickerVC animated:YES completion:^(void){}];
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
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

@end
