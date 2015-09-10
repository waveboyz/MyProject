//
//  MyAddressEditController.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyAddressEditController.h"

@interface MyAddressEditController ()

@property (nonatomic, copy) NSString *aid;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyAddressEditController

- (id)initWithAid:(NSString *)aid
{
    if (self = [super init]) {
        _aid = aid;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{

}

@end