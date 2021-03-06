//
//  HYQMainResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/8/26.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQMainResponse.h"
#import "ServiceModel.h"
#import "ActivityModel.h"
#import "BannerModel.h"

@interface HYQMainResponse ()

@property (nonatomic, assign) NSArray *imgArr;
@property (nonatomic, assign) NSArray *products;
@property (nonatomic, assign) NSArray *infoArr;
@property (nonatomic, assign) NSUInteger currentPage;

@end

@implementation HYQMainResponse

- (id)initWithPagesize:(NSUInteger)pagesize
{
    if (self = [super init]) {
        _currentPage = pagesize;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        [dic setObject:[NSNumber numberWithInteger:pagesize] forKey:@"pageSize"];
        [dic setObject:[NSNumber numberWithInteger:5] forKey:@"pageRow"];
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if (responseObject) {
            if ([responseObject objectForKey:@"code"]) {
                NSNumber *code = [responseObject objectForKey:@"code"];
                if ([code integerValue] == 1) {
                    if ([responseObject objectForKey:@"map"]) {
                        NSDictionary *dictionary = [responseObject objectForKey:@"map"];
                        if (_currentPage > 1) {
                            if ([dictionary objectForKey:@"products"]) {
                                _products = [ServiceModel objectArrayWithKeyValuesArray:[dictionary objectForKey:@"products"]];
                                
                                if (self.delegate && [self.delegate respondsToSelector:@selector(getMoreProducts:)]) {
                                    [self.delegate getMoreProducts:_products];
                                }
                            }else{
                                if (self.delegate && [self.delegate respondsToSelector:@selector(noDataArr)]) {
                                    [self.delegate noDataArr];
                                }
                            }
                        }else{
                        if ([dictionary objectForKey:@"banners"]) {
                            _imgArr = [BannerModel objectArrayWithKeyValuesArray:[dictionary objectForKey:@"banners"]];
                        }
                        
                        if ([dictionary objectForKey:@"articles"])         {
                            _infoArr = [ActivityModel objectArrayWithKeyValuesArray:[dictionary objectForKey:@"articles"]];
                        }
                        
                        if ([dictionary objectForKey:@"products"]) {
                            _products = [ServiceModel objectArrayWithKeyValuesArray:[dictionary objectForKey:@"products"]];
                        }
                        
                        if (_imgArr && _infoArr && _products) {
                            if (self.delegate && [self.delegate respondsToSelector:@selector(getMainInformationSucceedWithImgArr:andWithProducts:andWithInfo:)]) {
                                [self.delegate getMainInformationSucceedWithImgArr:_imgArr andWithProducts:_products andWithInfo:_infoArr];
                                }
                            }
                        }
                    }
                }else{
                    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
                        [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
                    }
            }
        }
    }
}

- (NSString *)methodPath
{
    return MAIN_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end