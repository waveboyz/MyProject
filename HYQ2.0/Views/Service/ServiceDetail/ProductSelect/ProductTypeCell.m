//
//  ProductTypeCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/21.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ProductTypeCell.h"
#import "ProductTypeModel.h"
#import "GlobalConst.h"

@interface ProductTypeCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) ProductTypeModel *selectModel;
@property (nonatomic, retain) NSMutableArray *btnArray;

@end

@implementation ProductTypeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BG_GRAY_COLOR;
        _btnArray = [NSMutableArray new];
        [self setViews];
    }
    
    return self;
}

- (void)setViews
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 120, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"服务类型:";
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, kScreenWidth - 30, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLbl];
    }
}

- (void)setTypeArr:(NSArray *)typeArr
{
    CGFloat width = 90.0f;
    CGFloat height = 25.0f;
    CGFloat blank = 15.0f;
    _typeArr = typeArr;
    NSInteger count = _typeArr.count;
    if (count) {
        for (int i = 0; i < count; i++) {
            ProductTypeModel *type = _typeArr[i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(blank + (blank + width) * (i % 3),50 + blank * (i / 3 + 1) + height * (i / 3), width, height);
            btn.titleLabel.font = [UIFont systemFontOfSize:9.0f];
            btn.tag = i;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[self createImageWithColor:NAVIBAR_GREEN_COLOR] forState:UIControlStateSelected];
            [btn setTitle:type.psname forState:UIControlStateNormal];
            [btn setTitle:type.psname forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(typeBtnPressedWith:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            [_btnArray addObject:btn];
        }
    }
    
    _lineLbl.frame = CGRectMake(15, 60 + (blank + height) * (count / 3 + 1), kScreenWidth - 30, 0.5);
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 0;
    [self typeBtnPressedWith:btn];
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


- (void)typeBtnPressedWith:(UIButton *)btn
{
    _selectModel = nil;
    _selectModel = _typeArr[btn.tag];
    NSInteger selecInt = btn.tag;
    for (int i = 0; i < _btnArray.count; i++) {
        UIButton *btn = _btnArray[i];
        if (btn.tag == selecInt) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectTypeModel:)]) {
        [self.delegate selectTypeModel:_selectModel];
    }
}

@end
