//
//  PersonalController.h
//  HYQ
//
//  Created by 周翔 on 15/6/15.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConst.h"
#import "BaseViewController.h"

@interface PersonalController : BaseViewController
<
    UITableViewDataSource,
    UITableViewDelegate,
    UIScrollViewDelegate,
    UIActionSheetDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>

@end
