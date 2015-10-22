//
//  ServiceSelectionView.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/19.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceSelectionView.h"
#import "GlobalConst.h"
#import "ProductModel.h"
#import "CalculateButtonHeight.h"
#import "ProductSelectImgCell.h"
#import "ProductTypeCell.h"
#import "ProductComboCell.h"

@interface ServiceSelectionView ()
<
    ProductComboCellDlegate,
    ProductTypeCellDlegate
>

@property (nonatomic, retain) NSMutableArray *typeArr;
@property (nonatomic, retain) NSMutableArray *comboArr;
@property (nonatomic, retain) NSMutableArray *selectComboArr;
@property (nonatomic, assign) ProductModel *product;
@property (nonatomic, assign) ProductTypeModel *selectType;

@end

@implementation ServiceSelectionView

- (id)initWithFrame:(CGRect)frame
     andWithProduct:(ProductModel *)product
     andWithTypeArr:(NSMutableArray *)typeArr
            andWith:(NSMutableArray *)comboArr
{
    if (self = [super initWithFrame:frame]) {
        _typeArr = typeArr;
        _comboArr = comboArr;
        _product = product;
        _selectComboArr = [NSMutableArray new];
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    self.backgroundColor = BG_GRAY_COLOR;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 220) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = BG_GRAY_COLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(15, kScreenHeight - 200, kScreenWidth - 30, 30);
    [confirmBtn setBackgroundColor:[UIColor whiteColor]];
    [confirmBtn setTitle:@"确认选择" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
}

- (void)confirmBtnPressed
{

}

#pragma mark UITableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SELECT_IMG_CELL = @"select_img_cell";
    static NSString *SELECT_TYPE_CELL = @"select_type_cell";
    static NSString *SELECT_COMBO_CELL = @"select_combo_cell";
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:SELECT_IMG_CELL];
        if (!cell) {
            cell = [[ProductSelectImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SELECT_IMG_CELL];
        }
        [(ProductSelectImgCell *)cell setProduct:_product];
        [(ProductSelectImgCell *)cell setType:_selectType];
        [(ProductSelectImgCell *)cell setComboArr:_selectComboArr];
    }else if (indexPath.row == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:SELECT_TYPE_CELL];
        if (!cell) {
            cell = [[ProductTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SELECT_TYPE_CELL];
            [(ProductTypeCell *)cell setDelegate:self];
        }
        [(ProductTypeCell *)cell setTypeArr:_typeArr];
    }else if (indexPath.row == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:SELECT_COMBO_CELL];
        if (!cell) {
            cell = [[ProductComboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SELECT_COMBO_CELL];
            [(ProductComboCell *)cell setDelegate:self];
        }
        [(ProductComboCell *)cell setComboArr:_comboArr];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150.5f;
    }else if (indexPath.row == 1){
        return [[CalculateButtonHeight calculate] calculateHeightWithString:_typeArr.count];
    }else if (indexPath.row == 2){
        return [[CalculateButtonHeight calculate] calculateHeightWithString:_comboArr.count];
    }
    
    return 20.0f;
}

#pragma mark    ProductComboCellDlegate
- (void)selectComboArrWith:(NSMutableArray *)comboArr
{
    [_selectComboArr removeAllObjects];
    _selectComboArr = [NSMutableArray arrayWithArray:comboArr];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark    ProductTypeCellDlegate
- (void)selectTypeModel:(ProductTypeModel *)type
{
    _selectType = nil;
    _selectType = type;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end