//
//  MainBannerCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/26.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MainBannerCell.h"
#import "SDCycleScrollView.h"

@interface MainBannerCell ()

@property (nonatomic, strong) SDCycleScrollView *cycleView;
@property (nonatomic, strong) NSMutableArray *imgArr;

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

- (NSMutableArray *)imgArr
{
    if (!_imgArr) {
        NSString *stringPath = [[NSBundle mainBundle] pathForResource:@"URLS.plist" ofType:nil];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:stringPath];
        NSArray *dicArr = [dic objectForKey:@"urls"];
        _imgArr = [NSMutableArray arrayWithArray:dicArr];
    }
    
    return _imgArr;
}

- (void)setViews
{
    if (!_cycleView) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 160) imageURLStringsGroup:self.imgArr];
        _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleView.placeholderImage = [UIImage imageNamed:@"notice_place_holder"];
        _cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        
        [self.contentView addSubview:_cycleView];
    }

}

@end