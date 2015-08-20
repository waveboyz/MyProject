//
//  ServicePurchaseController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServicePurchaseController.h"
#import "PurchaseHeaderCell.h"
#import "PurchaseSecondCell.h"

@interface ServicePurchaseController ()

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation ServicePurchaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = GRAY_COLOR;
    
    [self.view addSubview:_tableview];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PURCHASE_HEADER = @"purchase_header";
    static NSString *PURCHASE_SECOND = @"purchase_second";
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:PURCHASE_HEADER];
        if (!cell) {
            cell = [[PurchaseHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PURCHASE_HEADER];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:PURCHASE_SECOND];
        if (!cell) {
            cell = [[PurchaseSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PURCHASE_SECOND];
        }
    }
    
    return cell;
}

@end