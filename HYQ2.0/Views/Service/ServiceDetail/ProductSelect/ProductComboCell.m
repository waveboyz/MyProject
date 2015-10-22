//
//  ProductComboCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ProductComboCell.h"
#import "GlobalConst.h"
#import "ProductComboModel.h"

@interface ProductComboCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, retain) NSMutableArray *selectBtnArr;
@property (nonatomic, retain) NSMutableArray *selectDataArr;

@end

@implementation ProductComboCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BG_GRAY_COLOR;
        _selectBtnArr = [NSMutableArray new];
        _selectDataArr = [NSMutableArray new];
        [self setViews];
    }
    
    return self;
}


- (void)setViews
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 200, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"搭配产品（可多选）:";
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, kScreenWidth - 30, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLbl];
    }
}

- (void)setComboArr:(NSArray *)comboArr
{
    CGFloat width = 90.0f;
    CGFloat height = 25.0f;
    CGFloat blank = 15.0f;
    _comboArr = comboArr;
    NSInteger count = _comboArr.count;
    if (count) {
        for (int i = 0; i < count; i++) {
            ProductComboModel *combo = _comboArr[i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(blank + (blank + width) * (i % 3), 50 + blank * (i / 3 + 1) + height * (i / 3), width, height);
            btn.titleLabel.font = [UIFont systemFontOfSize:9.0f];
            btn.tag = i;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[self createImageWithColor:NAVIBAR_GREEN_COLOR] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(comboBtnPressedwith:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:combo.pdname forState:UIControlStateNormal];
            [btn setTitle:combo.pdname forState:UIControlStateSelected];
            [self.contentView addSubview:btn];
        }
    }
    
    _lineLbl.frame = CGRectMake(15, 60 + (blank + height) * (count / 3 + 1), kScreenWidth - 30, 0.5);
}

- (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)comboBtnPressedwith:(UIButton *)button
{
    button.selected = ! button.selected;
    
    if (button.selected) {
        [_selectBtnArr addObject:button];
    }else{
        [_selectBtnArr removeObject:button];
    }
    
    [self generateDataArr];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectComboArrWith:)]) {
        [self.delegate selectComboArrWith:_selectDataArr];
    }
}

- (void)generateDataArr
{
    [_selectDataArr removeAllObjects];
    
    for (UIButton *btn in _selectBtnArr) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [_selectDataArr addObject:_comboArr[btn.tag]];
        }
    }
    
    NSLog(@"%@",_selectDataArr);
}

@end