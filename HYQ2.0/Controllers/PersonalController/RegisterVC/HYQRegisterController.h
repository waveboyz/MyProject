//
//  HYQRegisterController.h
//  HYQ
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "BaseViewController.h"
/*
    注册
 */
@interface HYQRegisterController : BaseViewController
<
    UITextFieldDelegate
>

- (void)hideRegisterBoard;

- (id)initWithSuggestNumber:(NSString *)suggestNum;
@end
