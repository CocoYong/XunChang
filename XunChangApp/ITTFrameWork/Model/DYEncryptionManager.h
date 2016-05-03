//
//  DYEncryptionManager.h
//  DaoYouProject
//
//  Created by 成焱 on 15-2-3.
//  Copyright (c) 2015年 成焱. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DYEncryptionResult;

@interface DYEncryptionManager : NSObject
/**
 *  接口参数签名
 *
 *  @param url   访问的url
 *  @param param 访问的参数
 *
 *  @return 返回加密后的结果
 *
 *  @exception nil
 */
+ (DYEncryptionResult *)encryptionWithURL:(NSString *)url parameters:(NSDictionary *)param;
@end

@interface DYEncryptionResult : NSObject
/**
 *  加密后的url
 */
@property (nonatomic, copy) NSString *url;
/**
 *  加密后的参数列表
 */
@property (nonatomic, copy) NSDictionary *param;
@end