//
//  PurchaseHeaderCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "PurchaseHeaderCell.h"

@interface PurchaseHeaderCell ()

@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *phoneLbl;
@property (nonatomic, strong) UILabel *addLbl;

@end

@implementation PurchaseHeaderCell

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
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 20)];
        _nameLbl.font = [UIFont systemFontOfSize:15.0f];
        _nameLbl.text = @"收货人：习大大";
        _nameLbl.textColor = [UIColor blackColor];
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:_nameLbl.text];
        NSRange range = NSMakeRange(0, attStr.length);
        NSDictionary *dic = [attStr attributesAtIndex:0 effectiveRange:&range];
        CGSize size = [_nameLbl.text boundingRectWithSize:CGSizeMake(120 , 20)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:dic
                                                        context:nil].size;
        _nameLbl.frame = CGRectMake(10, 10, size.width, 20);
        [self.contentView addSubview:_nameLbl];
    }
    
    if (!_phoneLbl) {
        _phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 10, 120, 20)];
        _phoneLbl.textColor = [UIColor blackColor];
        _phoneLbl.font = [UIFont systemFontOfSize:15.0f];
        
        [self.contentView addSubview:_phoneLbl];
    }
}

@end