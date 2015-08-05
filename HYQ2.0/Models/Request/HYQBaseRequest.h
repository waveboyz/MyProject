//
//  HYQBaseRequest.h
//  HYQ
//
//  Created by 周翔 on 15/6/19.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HYQBaseRequestDelegate <NSObject>

- (void)responseWithJsonData:(id)responseObject;

- (void)getResponseFaild;

@end

@interface HYQBaseRequest : NSObject

@property (assign, nonatomic)   id<HYQBaseRequestDelegate> delegate;
@property (strong, nonatomic) NSMutableDictionary     * params;
@property (strong, nonatomic)   NSData                  * imageData;
@property (strong, nonatomic)   NSString                * imageName;

//无输入参数初始化
- (id)initWithNone;

//操作接口号路径
- (NSString *)methodPath;

//查询数据，这里会把公用的uid/token/time之类的数据附加进去
- (NSDictionary *)query;

//封装后的查询请求
- (NSURLRequest *)req;

//该接口是否需要用户授权才能调用,默认为YES
- (BOOL)isPrivate;

//该接口是否包含图片,默认为NO
- (BOOL)isImageInclude;

//启动请求
- (void)start;

@end
