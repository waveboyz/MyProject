//
//  HYQUserManager.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/19.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQUserManager.h"

#define ENCODE_KEY          @"HAOYUANQU"

static HYQUserManager *_sharedUserManager;
static NSString *const __kUserInfoFileName = @"B911B8BD1CCD76D0";
static NSString *const __kPasswordInfoFileName = @"C2BC1692D60AAC29";

@interface HYQUserManager ()

- (NSString *)userFileFullPath;
- (NSString *)pswFileFullPath;
- (NSData *)simpleEncode:(NSString *)s;
- (NSString *)simpleDecode:(NSData *)s;

@end

@implementation HYQUserManager

+ (HYQUserManager *)sharedUserManager
{
    if (!_sharedUserManager) {
        _sharedUserManager = [[HYQUserManager alloc] init];
    }
    
    return _sharedUserManager;
}

- (BOOL)isLogin
{
    NSDictionary *info = [self userInfo];
    
    if ([info objectForKey:@"uid"] && [info objectForKey:@"pwd"]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)logout
{
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] initWithDictionary:[self userInfo]];
    
    [userDict removeObjectForKey:@"username"];
    [userDict removeObjectForKey:@"uid"];
    [userDict removeObjectForKey:@"pwd"];
    
    [self updateUserInfo:userDict];
    
    return YES;
}

- (BOOL)isRememberPsw
{
    NSDictionary *info = [self userInfo];
    
    if (info && [[info objectForKey:@"rememberPsw"] isEqualToString:@"true"]) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Save and Get Password
- (BOOL)savePsw:(NSString *)psw
{
    NSString *path = [self pswFileFullPath];
    
    //    Clear Saved Password
    if (!psw || [psw isEqualToString:@""]) {
        NSFileManager *fm = [NSFileManager defaultManager];
        return [fm removeItemAtPath:path error:nil];
    }
    NSData *pswArchivered = [self simpleEncode:psw];
    
    return [NSKeyedArchiver archiveRootObject:pswArchivered toFile:path];
}

- (NSString *)getPsw
{
    NSString *path = [self pswFileFullPath];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:path]) {
        NSData *psw = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (psw && [psw length] > 0) {
            return [self simpleDecode:psw];
        }
    }
    
    return nil;
}

#pragma mark - Save and Get User Info
- (NSDictionary *)userInfo
{
    NSString *path = [self userFileFullPath];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:path]) {
        NSDictionary *info = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if ([info.allKeys count] > 0) {
            return info;
        }
    }
    
    return nil;
}

- (BOOL)updateUserInfo:(NSDictionary *)userData
{
    NSString *path = [self userFileFullPath];
    
    return [NSKeyedArchiver archiveRootObject:userData toFile:path];
}

- (NSString *)userFileFullPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullPath = [path stringByAppendingPathComponent:__kUserInfoFileName];
    
    return fullPath;
}

- (NSString *)pswFileFullPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullPath = [path stringByAppendingPathComponent:__kPasswordInfoFileName];
    
    return fullPath;
}

#pragma mark - Encode and Decode
- (NSData *)simpleEncode:(NSString *)s
{
    NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
    
    char *dataPtr = (char *)[data bytes];
    char *keyData = (char *)[[ENCODE_KEY dataUsingEncoding:NSUTF8StringEncoding] bytes];
    char *keyPtr = keyData;
    int keyIndex = 0;
    
    for (int i = 0; i < [data length]; i++) {
        *dataPtr = *dataPtr ^ *keyPtr;
        dataPtr++;
        keyPtr++;
        
        if (++keyIndex == [ENCODE_KEY length]) {
            keyIndex = 0;
            keyPtr = keyData;
        }
    }
    
    return data;
}

- (NSString *)simpleDecode:(NSData *)s
{
    NSData *data = [NSData dataWithData:s];
    
    char *dataPtr = (char *)[data bytes];
    char *keyData = (char *)[[ENCODE_KEY dataUsingEncoding:NSUTF8StringEncoding] bytes];
    char *keyPtr = keyData;
    int keyIndex =0;
    
    for (int i = 0; i < [data length]; i++) {
        *dataPtr = *dataPtr ^ *keyPtr;
        dataPtr++;
        keyPtr++;
        
        if (++keyIndex == [ENCODE_KEY length]) {
            keyIndex = 0;
            keyPtr = keyData;
        }
    }
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

@end
