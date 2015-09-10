//
//  ReplaceAvartarResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/2.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ReplaceAvartarResponse.h"
#import "AFNetworking.h"
#import "HYQUserManager.h"
#import "GlobalConst.h"

@interface ReplaceAvartarResponse ()

@property (nonatomic, assign) UIImage *imageData;

@end

@implementation ReplaceAvartarResponse

- (id)initWith:(UIImage *)image
{
    if (self = [super init]) {
        _imageData = image;
    }
    
    return self;
}

- (void)start
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager            POST:[self methodPath]
                  parameters:self.params
   constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       NSData *imageData = UIImageJPEGRepresentation(_imageData, 1);
       
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       formatter.dateFormat = @"yyyyMMddHHmmss";
       NSString *str = [formatter stringFromDate:[NSDate date]];
       NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
       
       // 上传图片，以文件流的格式
       [formData appendPartWithFileData:imageData name:@"avatar" fileName:fileName mimeType:@"image/jpeg"];
                   } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       [self decodeJsonOperationWithObject:responseObject];
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"%@",error);
                       [self badNetWork];
                   }];
}
                                              
- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if ([[responseObject objectForKey:@"code"] integerValue] == 0) {
        if ([responseObject objectForKey:@"path"]) {
            NSString *str = [responseObject objectForKey:@"path"];
            NSString *UrlStr = [NSString stringWithFormat:@"%@%@",IMAGE_HOST,str];
            if (self.delegate && [self.delegate respondsToSelector:@selector(replaceAvatarSucceedWithUrl:)]) {
                [self.delegate replaceAvatarSucceedWithUrl:UrlStr];
            }
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
            [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
        }
    }
}

- (NSString *)methodPath
{
    return REPLACE_AVATAR_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}
@end