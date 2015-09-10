//
//  MyCollectController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/4.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyCollectController.h"
#import "MyCollectCell.h"
#import "MyCollectResponse.h"
#import "MyCollectDeleteResponse.h"
#import "CollectModel.h"

@interface MyCollectController ()
<
    MyCollectResponseDelegate,
    MyCollectDeleteResponseDelegate
>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, retain) NSMutableArray *dataArr;
@property (nonatomic, retain) NSMutableArray *deleteIndexArr;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIView *badNetView;
@property (nonatomic, strong) UIBarButtonItem *editBtn;
@property (nonatomic, strong) UIBarButtonItem *cancelBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, retain) NSIndexPath *deleteIndex;

@end

@implementation MyCollectController

- (id)init
{
    if (self = [super init]) {
        _dataArr = [NSMutableArray new];
        _deleteIndexArr = [NSMutableArray new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self createUI];
}

- (void)getCollectOperation
{
    [self showNoTextStateHud];
    MyCollectResponse *response = [[MyCollectResponse alloc] init];
    response.delegate = self;
    [response start];
}

- (void)createUI
{
    self.navigationItem.rightBarButtonItem = self.editBtn;
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableview.delegate =self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = GRAY_COLOR;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableview];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame = CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49);
    _deleteBtn.hidden = YES;
    [_deleteBtn setBackgroundColor:ORANGE_COLOR];
    [_deleteBtn setTitle:@"删除所选" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteSelectedCollect) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_deleteBtn];
    
    [self getCollectOperation];
}

- (UIBarButtonItem *)editBtn
{
    if (!_editBtn) {
        _editBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editBtnPressed)];
    }
    
    return _editBtn;
}

- (UIBarButtonItem *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelEdit)];
    }
    
    return _cancelBtn;
}

- (void)editBtnPressed
{
    _tableview.allowsMultipleSelectionDuringEditing = YES;
    [_tableview setEditing:YES animated:YES];
    [self.view bringSubviewToFront:_deleteBtn];
    _deleteBtn.hidden = NO;
    self.navigationItem.rightBarButtonItem = self.cancelBtn;
    self.deleteBtn.hidden = NO;
}

- (void)cancelEdit
{
    [_tableview setEditing:NO animated:YES];
    _deleteBtn.hidden = YES;
    [_deleteIndexArr removeAllObjects];
    self.navigationItem.rightBarButtonItem = self.editBtn;
    self.deleteBtn.hidden = YES;
}

- (UIView *)badNetView
{
    if (!_badNetView) {
        _badNetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _badNetView.backgroundColor = GRAY_COLOR;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, kScreenHeight * 0.5 - 40, kScreenWidth, 80);
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(getCollectOperation) forControlEvents:UIControlEventTouchUpInside];
        
        [_badNetView addSubview:btn];
    }
    
    return _badNetView;
}

- (UIView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _emptyView.backgroundColor = GRAY_COLOR;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, kScreenHeight * 0.5 - 40, kScreenWidth, 80);
        [btn setTitle:@"暂无记录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(getCollectOperation) forControlEvents:UIControlEventTouchUpInside];
        
        [_emptyView addSubview:btn];
    }
    
    return _emptyView;
}

- (void)deleteSelectedCollect
{
    _deleteIndexArr = [NSMutableArray arrayWithArray:[self.tableview indexPathsForSelectedRows]];
    if (_deleteIndexArr.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请至少选择一个收藏"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [self deleteMultiCollect];
    }
}

- (void)deleteSingleOperationWith:(NSArray *)arr
{
    [self showNoTextStateHud];
    MyCollectDeleteResponse *response = [[MyCollectDeleteResponse alloc] initWithDeleteArr:arr];
    response.delegate = self;
    [response start];
}

- (void)deleteMultiCollect
{
    [self showNoTextStateHud];
    NSMutableArray *arr = [NSMutableArray new];
    for (NSIndexPath *selectionIndex in _deleteIndexArr)
    {
        CollectModel *model = _dataArr[selectionIndex.row];
        [arr addObject:model.fid];
    }
    
    MyCollectDeleteResponse *response = [[MyCollectDeleteResponse alloc] initWithDeleteArr:arr];
    response.delegate = self;
    [response start];
}

#pragma mark MyCollectResponseDelegate
- (void)getCollectListWithArray:(NSMutableArray *)colArr
{
    self.dataArr = colArr;
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self stopStateHud];
        [self.tableview reloadData];
        [self.view bringSubviewToFront:self.tableview];
    });
}

- (void)wrongOperationWithText:(NSString *)text
{
    [self stopStateHud];
    [self.view bringSubviewToFront:self.badNetView];
}

- (void)noDataArr
{
    [self stopStateHud];
    [self.view bringSubviewToFront:self.emptyView];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *COLLECT_CELL = @"collect_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COLLECT_CELL];
    if (!cell) {
        cell = [[MyCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:COLLECT_CELL];
    }
    [(MyCollectCell *)cell setCollect:self.dataArr[indexPath.row]];
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select%ld",indexPath.row);
    if (![self.tableview isEditing]) {
        [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.5f;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectModel *model = _dataArr[indexPath.row];
    NSArray *arr = [NSArray arrayWithObject:model.fid];
    _deleteIndex = [NSIndexPath indexPathForItem:indexPath.row inSection:indexPath.section];
    [self deleteSingleOperationWith:arr];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark MyCollectDeleteResponseDelegate
- (void)deleteSucceed
{
    [self stopStateHud];
    [self showStateHudWithText:@"删除成功"];
    if (_deleteIndex) {
        [_dataArr removeObjectAtIndex:_deleteIndex.row];
        [self.tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:_deleteIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
        _deleteIndex = nil;
    }else if(_deleteIndexArr.count){
        NSMutableIndexSet *indicesOfItemsToDelete = [NSMutableIndexSet new];
        for (NSIndexPath *selectionIndex in _deleteIndexArr)
        {
            [indicesOfItemsToDelete addIndex:selectionIndex.row];
        }
        [_dataArr removeObjectsAtIndexes:indicesOfItemsToDelete];
        [self.tableview deleteRowsAtIndexPaths:_deleteIndexArr withRowAnimation:UITableViewRowAnimationAutomatic];
        [_deleteIndexArr removeAllObjects];
    }
}

- (void)deleteFalse
{
    [self stopStateHud];
    [self showStateHudWithText:@"删除失败"];
}

@end