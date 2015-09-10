//
//  ActivityModel.h
//  HYQ
//
//  Created by waveboyz on 15/6/26.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface ActivityModel : BaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *editor;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, strong) NSNumber *hits;
@property (nonatomic, strong) NSNumber *aid;

@end