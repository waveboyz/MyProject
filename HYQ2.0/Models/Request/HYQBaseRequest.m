//
//  HYQBaseRequest.m
//  HYQ
//
//  Created by 周翔 on 15/6/19.
//  Copyright (c) 2015年 haoyuanqu. All rights reserved.
//

#import "HYQBaseRequest.h"
#import "AFHTTPRequestOperationManager.h"

@implementation HYQBaseRequest

//无输入参数初始化
- (id)initWithNone
{
    if (self = [super init]) {
        
    }

    return self;
}

- (NSMutableDictionary *)params
{
    if (nil == self.params) {
        self.params = [NSMutableDictionary dictionaryWithCapacity:2];
    }
    return self.params;
}

//操作接口号路径
- (NSString *)methodPath
{
    return nil;
}

//查询数据，这里会把公用的uid/token/time之类的数据附加进去
- (NSDictionary *)query
{
    return nil;
}

//封装后的查询请求
- (NSURLRequest *)req
{
    return nil;
}

//该接口是否需要用户授权才能调用,默认为YES
- (BOOL)isPrivate
{
    return YES;
}

//该接口是否包含图片,默认为NO
- (BOOL)isImageInclude
{
    return NO;
}

- (void)start
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[self methodPath] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFormData:[self toJSONData:[self query]]
                                    name:@"json_package"];
        
        if ([self isImageInclude] && _imageData) {
            [formData appendPartWithFileData:_imageData
                                        name:_imageName
                                    fileName:[NSString stringWithFormat:@"%@.jpg", _imageName]
                                    mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self getResponseSucceedWithJsonData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self getResponseFaildOperation];
    }];
}

- (NSData *)toJSONData:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil) {
        return jsonData;
    } else {
        return nil;
    }
}

- (void)getResponseSucceedWithJsonData:(id)responseObject
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(responseWithJsonData:)]) {
        [self.delegate responseWithJsonData:responseObject];
    }
}

- (void)getResponseFaildOperation
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(getResponseFaild)]) {
        [self.delegate getResponseFaild];
    }
}
@end