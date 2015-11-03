//
//  RefundSecondCell.m
//  HYQ2.0
//
//  Created by 周翔 on 15/10/27.
//  Copyright © 2015年 HZHaoYuanQu. All rights reserved.
//

#import "RefundSecondCell.h"
#import "GlobalConst.h"

@interface RefundSecondCell ()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *lineLbl;
@property (nonatomic, strong) UILabel *desLbl1;
@property (nonatomic, strong) UILabel *desLbl2;
@property (nonatomic, strong) UILabel *desLbl3;
@property (nonatomic, strong) UILabel *desLbl4;
@property (nonatomic, strong) UILabel *desLbl5;
@property (nonatomic, strong) UILabel *desLbl6;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;
@property (nonatomic, strong) UIButton *button5;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, retain) NSMutableArray *selectBtns;
@property (nonatomic, retain) NSMutableArray *selectReasons;

@end

@implementation RefundSecondCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        _selectReasons = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3"]];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}


- (void)setViews
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 150, 20)];
        _titleLbl.font = [UIFont systemFontOfSize:17.0f];
        _titleLbl.textColor = [UIColor blackColor];
        NSString *str = @"退款原因(至少选一项)";
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attStr setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17.0f]} range:NSMakeRange(0, 3)];
        [attStr setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} range:NSMakeRange(4, 7)];
        _titleLbl.attributedText = attStr;
        [self.contentView addSubview:_titleLbl];
    }
    
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, kScreenWidth - 30, 0.5)];
        _lineLbl.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLbl];
    }
    
    if (!_desLbl1) {
        _desLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, kScreenWidth - 60, 20)];
        _desLbl1.font = [UIFont systemFontOfSize:13.0f];
        _desLbl1.textColor = [UIColor blackColor];
        _desLbl1.text = @"突然不想要了";
        [self.contentView addSubview:_desLbl1];
    }
    
    if (!_desLbl2) {
        _desLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, kScreenWidth - 60, 20)];
        _desLbl2.font = [UIFont systemFontOfSize:13.0f];
        _desLbl2.textColor = [UIColor blackColor];
        _desLbl2.text = @"排错产品了，想重新购买";
        [self.contentView addSubview:_desLbl2];
    }
    
    if (!_desLbl3) {
        _desLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, kScreenWidth - 60, 20)];
        _desLbl3.font = [UIFont systemFontOfSize:13.0f];
        _desLbl3.textColor = [UIColor blackColor];
        _desLbl3.text = @"未按约定时间提供服务";
        [self.contentView addSubview:_desLbl3];
    }
    
    if (!_desLbl4) {
        _desLbl4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 150, kScreenWidth - 60, 20)];
        _desLbl4.font = [UIFont systemFontOfSize:13.0f];
        _desLbl4.textColor = [UIColor blackColor];
        _desLbl4.text = @"感觉价格偏贵";
        [self.contentView addSubview:_desLbl4];
    }
    
    if (!_desLbl5) {
        _desLbl5 = [[UILabel alloc] initWithFrame:CGRectMake(15, 180, kScreenWidth - 60, 20)];
        _desLbl5.font = [UIFont systemFontOfSize:13.0f];
        _desLbl5.textColor = [UIColor blackColor];
        _desLbl5.text = @"对服务结果不满意";
        [self.contentView addSubview:_desLbl5];
    }
    
    if (!_desLbl6) {
        _desLbl6 = [[UILabel alloc] initWithFrame:CGRectMake(15, 210, kScreenWidth - 60, 20)];
        _desLbl6.font = [UIFont systemFontOfSize:13.0f];
        _desLbl6.textColor = [UIColor blackColor];
        _desLbl6.text = @"其他原因";
        [self.contentView addSubview:_desLbl6];
    }

    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.frame = CGRectMake(kScreenWidth - 30, 60, 20, 20);
        _button1.selected = YES;
        _button1.tag = 0;
        _button1.imageView.contentMode = UIViewContentModeRedraw;
        [_button1 setBackgroundImage:[UIImage imageNamed:@"refund_unselect"] forState:UIControlStateNormal];
        [_button1 setBackgroundImage:[UIImage imageNamed:@"refund_select"] forState:UIControlStateSelected];
        [_button1 addTarget:self action:@selector(reasonBtnPressedWith:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button1];
    }
    
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button2.frame = CGRectMake(kScreenWidth - 30, 90, 20, 20);
        _button2.selected = YES;
        _button2.tag = 1;
        _button2.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_button2 setBackgroundImage:[UIImage imageNamed:@"refund_unselect"] forState:UIControlStateNormal];
        [_button2 setBackgroundImage:[UIImage imageNamed:@"refund_select"] forState:UIControlStateSelected];
        [_button2 addTarget:self action:@selector(reasonBtnPressedWith:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button2];
    }
    
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button3.frame = CGRectMake(kScreenWidth - 30, 120, 20, 20);
        _button3.selected = YES;
        _button3.tag = 2;
        _button3.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_button3 setBackgroundImage:[UIImage imageNamed:@"refund_unselect"] forState:UIControlStateNormal];
        [_button3 setBackgroundImage:[UIImage imageNamed:@"refund_select"] forState:UIControlStateSelected];
        [_button3 addTarget:self action:@selector(reasonBtnPressedWith:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button3];
    }
    
    if (!_button4) {
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button4.frame = CGRectMake(kScreenWidth - 30, 150, 20, 20);
        _button4.tag = 3;
        _button4.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_button4 setBackgroundImage:[UIImage imageNamed:@"refund_unselect"] forState:UIControlStateNormal];
        [_button4 setBackgroundImage:[UIImage imageNamed:@"refund_select"] forState:UIControlStateSelected];
        [_button4 addTarget:self action:@selector(reasonBtnPressedWith:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button4];
    }
    
    if (!_button5) {
        _button5 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button5.frame = CGRectMake(kScreenWidth - 30, 180, 20, 20);
        _button5.tag = 4;
        _button5.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_button5 setBackgroundImage:[UIImage imageNamed:@"refund_unselect"] forState:UIControlStateNormal];
        [_button5 setBackgroundImage:[UIImage imageNamed:@"refund_select"] forState:UIControlStateSelected];
        [_button5 addTarget:self action:@selector(reasonBtnPressedWith:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button5];
    }
    
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 240, kScreenWidth - 30, 80)];
        _textView.backgroundColor = BG_GRAY_COLOR;
        _textView.textColor = [UIColor blackColor];
        [self.contentView addSubview:_textView];
    }
    
    _selectBtns = [NSMutableArray arrayWithArray:@[_button1,_button2,_button3]];
}

- (void)reasonBtnPressedWith:(UIButton *)button
{
    button.selected = !button.selected;
    NSLog(@"%@ pressed",button);
    
    if (button.selected) {
        [_selectBtns addObject:button];
    }else{
        [_selectBtns removeObject:button];
    }
    
    [self generateDataArr];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectReasonsWith:)]) {
        [self.delegate selectReasonsWith:_selectReasons];
    }
}

- (void)generateDataArr
{
    [_selectReasons removeAllObjects];
    
    for (UIButton *btn in _selectBtns) {
        switch (btn.tag) {
            case 0:
                [_selectReasons addObject:@"1"];
                break;
                
            case 1:
                [_selectReasons addObject:@"2"];
                break;
                
            case 2:
                [_selectReasons addObject:@"3"];
                break;
                
            case 3:
                [_selectReasons addObject:@"4"];
                break;
                
            case 4:
                [_selectReasons addObject:@"5"];
                break;
                
            default:
                break;
        }
    }
}

@end
