//
//  ServiceIsCollectResponse.m
//  HYQ2.0
//
//  Created by 周翔 on 15/9/7.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "ServiceIsCollectResponse.h"
#import "ProductModel.h"
#import "EvaluateModel.h"
#import "ProductTypeModel.h"
#import "ProductComboModel.h"
#import "HYQUserManager.h"

@implementation ServiceIsCollectResponse

- (id) initWithPid:(NSNumber *)pid andWithPTID:(NSNumber *)ptid
{
    if (self = [super init]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        if (pid) {
            [dic setObject:pid forKey:@"pid"];
        }
        if (ptid) {
            [dic setObject:ptid forKey:@"ptid"];
        }

        NSDictionary *userInfo = [[HYQUserManager sharedUserManager] userInfo];
        [dic setObject:[userInfo objectForKey:@"uid"] forKey:@"uid"];
        [self setUploadDictionary:dic];
    }
    
    return self;
}

- (void)decodeJsonOperationWithObject:(id)responseObject
{
    NSLog(@"%@",responseObject);
    if (responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == 1) {
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(getCollectSucceedWithIsCollected:andWith:andWith:andWith:andwith:)]) {
                NSNumber *isCollected = [responseObject objectForKey:@"iSFavorite"];
                NSDictionary *productDic = [responseObject objectForKey:@"product"];
                ProductModel *product = [ProductModel objectWithKeyValues:productDic];
                
                NSDictionary *evaluatedic = [responseObject objectForKey:@"evaluate"];
                EvaluateModel *evaluate = [EvaluateModel objectWithKeyValues:evaluatedic];
                
                NSArray *typedic = [responseObject objectForKey:@"productDetatilType"];
                NSMutableArray *typeArr = [ProductTypeModel objectArrayWithKeyValuesArray:typedic];
                
                NSArray *combodic = [responseObject objectForKey:@"productDetatil"];
                NSMutableArray *comboArr = [ProductComboModel objectArrayWithKeyValuesArray:combodic];
                
                [self.delegate getCollectSucceedWithIsCollected:[isCollected boolValue]
                                                        andWith:product
                                                        andWith:evaluate
                                                        andWith:comboArr
                                                        andwith:typeArr];
            }
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
                [self.delegate wrongOperationWithText:[responseObject objectForKey:@"msg"]];
            }
            
        }
    }
}

- (NSString *)methodPath
{
    return SERVICE_INFO_INTERFACE;
}

- (void)badNetWork
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(wrongOperationWithText:)]) {
        [self.delegate wrongOperationWithText:@"网络不给力哦~"];
    }
}

@end
