//
//  ServiceDetailHeadCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/14.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceDetailHeadCell.h"
#import "SDCycleScrollView.h"

@interface ServiceDetailHeadCell ()

@property (nonatomic, strong) SDCycleScrollView *cycleView;
@property (nonatomic, assign) NSMutableArray *imgArr;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *currentPriLbl;
@property (nonatomic, strong) UILabel *oldPriceLbl;

@end

@implementation ServiceDetailHeadCell

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
    NSString *stringPath = [[NSBundle mainBundle] pathForResource:@"URLS.plist" ofType:nil];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:stringPath];
    NSArray *dicArr = [dic objectForKey:@"urls"];
    NSMutableArray *listArr = [NSMutableArray arrayWithArray:dicArr];
    
    return listArr;
}

- (void)setViews
{
    if (!_cycleView) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 300) imageURLStringsGroup:self.imgArr];
        _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleView.placeholderImage = [UIImage imageNamed:@"notice_place_holder"];
        _cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    
        [self.contentView addSubview:_cycleView];
    }

    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 310, kScreenWidth - 10, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:15.0f];
        _titleLbl.text = @"财务软件记账宝正版代理记账软件";
        _titleLbl.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_currentPriLbl) {
        _currentPriLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 340, 0, 20)];
        _currentPriLbl.textColor = [UIColor redColor];
        _currentPriLbl.font = [UIFont systemFontOfSize:17.0f];
        _currentPriLbl.text = @"￥260.00";
        
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:_currentPriLbl.text];
        NSRange range = NSMakeRange(0, attStr.length);
        NSDictionary *dic = [attStr attributesAtIndex:0 effectiveRange:&range];
        CGSize size = [_currentPriLbl.text boundingRectWithSize:CGSizeMake(kScreenWidth * 0.5, 20) options:NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil].size;
        _currentPriLbl.frame = CGRectMake(10, 340, size.width, 20);
        
        [self.contentView addSubview:_currentPriLbl];
    }
    
    if (!_oldPriceLbl) {
        _oldPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_oldPriceLbl.frame) + 5, CGRectGetMaxY(_oldPriceLbl.frame) - 15, 120, 15)];
        _oldPriceLbl.font = [UIFont systemFontOfSize:130.f];
        _oldPriceLbl.textColor = GRAY_COLOR;
        NSString *str = @"原价：￥350";
        
        NSUInteger length = [str length];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(2, length - 2)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:GRAY_COLOR range:NSMakeRange(0, length)];
        [_oldPriceLbl setAttributedText:attri];
        
        [self.contentView addSubview:_oldPriceLbl];
    }

}
@end
