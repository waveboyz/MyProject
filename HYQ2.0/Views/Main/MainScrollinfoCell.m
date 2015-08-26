//
//  MainScrollinfoCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/20.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MainScrollinfoCell.h"
#import "ScrollDetailCell.h"

@interface MainScrollinfoCell ()

@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UILabel     *lineLbl;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, assign) NSInteger    timeTerval;

@end

@implementation MainScrollinfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.timeTerval = 0;
    }
    
    return self;
}

- (void)setViews
{
    CGFloat IconWidth = (kScreenWidth - 160) / 4;
    
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, IconWidth + 20, 20)];
        _titleImg.image = [UIImage imageNamed:@"info_scroll"];
        
        [self.contentView addSubview:_titleImg];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(IconWidth + 35, 10, 0.5, 20)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(IconWidth + 40, 0, kScreenWidth - IconWidth - 40, 40) style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.userInteractionEnabled = NO;
        
        [self.contentView addSubview:_tableview];
    }
    
    [self setupTimer];
}

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3
                                                      target:self
                                                    selector:@selector(automaticScroll)
                                                    userInfo:nil
                                                     repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll
{
    if (_timeTerval < 10) {
        [_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:_timeTerval inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        _timeTerval += 1;
    }else{
        [_tableview scrollsToTop];
        _timeTerval = 0;
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SCROLL_CELL = @"scroll_cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:SCROLL_CELL];
    
    if (!cell) {
        cell = [[ScrollDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SCROLL_CELL];
    }
        [(ScrollDetailCell *)cell setTitleInt:indexPath.row];
    
    return cell;
}

#pragma mark UITablieviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

@end