//
//  MainBannerCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/26.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MainBannerCell.h"
#import "SDCycleScrollView.h"
#import "HYQInterfaceMethod.h"
#import "BannerModel.h"

@interface MainBannerCell ()

@property (nonatomic, strong) SDCycleScrollView *cycleView;

@end

@implementation MainBannerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setImgArr:(NSArray *)imgArr
{
    _imgArr = imgArr;
    NSMutableArray *arr = [NSMutableArray new];
    
    for (BannerModel *obj in _imgArr) {
        NSString *str = obj.path;
        [arr addObject:str];
    }
    
    _cycleView.imageURLStringsGroup = arr;
}

- (void)setViews
{
    if (!_cycleView) {
        
        _cycleView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 205)];
        _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleView.placeholderImage = [UIImage imageNamed:@"banner_placeholder"];
        _cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        
        [self.contentView addSubview:_cycleView];
    }
}

@end