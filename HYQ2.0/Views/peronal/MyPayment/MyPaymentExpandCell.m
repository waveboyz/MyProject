//
//  MyPaymentExpandCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "MyPaymentExpandCell.h"
#import "GlobalConst.h"

@interface MyPaymentExpandCell ()

@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *timeLbl;
@property (nonatomic, strong) UILabel *lineLbl;

@end

@implementation MyPaymentExpandCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
    }
    
    return self;
}

- (void)setViews
{
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, 40)];
        _nameLbl.font = [UIFont systemFontOfSize:15.0f];
        _nameLbl.textColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLbl];
    }
    
    if(!_timeLbl){
        _timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5, 0, kScreenWidth*0.5 - 20, 40)];
        _timeLbl.font = [UIFont systemFontOfSize:13.0f];
        _timeLbl.textColor = ORANGE_COLOR;
        _timeLbl.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_timeLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, kScreenWidth - 15, 0.5)];
        _lineLbl.backgroundColor = BG_GRAY_COLOR;
        [self.contentView addSubview:_lineLbl];
    }
}

- (void)setExpand:(ExpandModel *)expand
{
    NSLog(@"%@",expand.name);
    
    if ([expand.name stringValue]) {
        NSString *str = [[expand.name stringValue] stringByReplacingCharactersInRange:NSMakeRange(3, 6) withString:@"****"];
        _nameLbl.text = str;
    }
    
    if (expand.time) {
        _timeLbl.text = expand.time;
    }
}

@end