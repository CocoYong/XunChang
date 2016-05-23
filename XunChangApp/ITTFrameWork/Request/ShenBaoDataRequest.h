//
//  ShenBaoDataRequest.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/14.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShenBaoDataRequest : NSObject
typedef void(^CompletionLoad)(id result);
typedef void(^ErrorBlock)(NSError *error);
typedef void(^NoNetWork)(NSString *noNetWorking);
+(void)requestWithNormalURL:(NSString*)url
                     params:(NSMutableDictionary*)params
                httpMesthod:(NSString*)httpMethod
                      block:(CompletionLoad)successblock
                 errorBlock:(ErrorBlock)errorBlock
               noNetWorking:(NoNetWork)noNetworking;

//AFNetworking
+ (void)requestAFWithURL:(NSString *)url
                  params:(NSMutableDictionary *)params
              httpMethod:(NSString *)httpMethod
                   block:(CompletionLoad)successblock
              errorBlock:(ErrorBlock)errorBlock
            noNetWorking:(NoNetWork)noNetworking;

//上传单张图片+其他参数的用这个哈
+(void)requestUpLoadImageurl:(NSString *)url
                      params:(NSMutableDictionary*)params
                  httpMethod:(NSString*)httpMethod
                   imageData:(UIImage*)updateImage
                    fileName:(NSString*)fileName
              iamgeUrlParams:(NSString*)imageUrlParams
        successCallBackBlock:(CompletionLoad)successBlock
                  errorBlock:(ErrorBlock)errorBlock
           noNetworkingBlock:(NoNetWork)noNetWorkingBlock;
//上传图片
+(void)requestUpLoadImageData:(UIImage*)updateImage
                     fileName:(NSString*)fileName
         successCallBackBlock:(CompletionLoad)successBlock
                   errorBlock:(ErrorBlock)errorBlock
            noNetworkingBlock:(NoNetWork)noNetWorkingBlock;
@end
