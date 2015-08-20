//
//  PurchaseSecondCell.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "PurchaseSecondCell.h"

@interface PurchaseSecondCell ()

@property (nonatomic, strong) UIImageView       *titleImg;
@property (nonatomic, strong) UILabel           *titleLbl;
@property (nonatomic, strong) UILabel           *priceLbl;
@property (nonatomic, strong) UILabel           *desLbl1;
@property (nonatomic, strong) UILabel           *desLbl2;
@property (nonatomic, strong) UILabel           *desLbl3;
@property (nonatomic, strong) UILabel           *lineLbl1;
@property (nonatomic, strong) UILabel           *lineLbl2;
@property (nonatomic, strong) UILabel           *lineLbl3;

@end

@implementation PurchaseSecondCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setViews
{

}

@end