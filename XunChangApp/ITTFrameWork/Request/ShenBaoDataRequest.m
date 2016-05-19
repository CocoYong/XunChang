//
//  ShenBaoDataRequest.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/14.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "ShenBaoDataRequest.h"
@implementation ShenBaoDataRequest
+(void)requestWithNormalURL:(NSString*)url
                     params:(NSMutableDictionary*)params
                httpMesthod:(NSString*)httpMethod
                      block:(CompletionLoad)successblock
                 errorBlock:(ErrorBlock)errorBlock
               noNetWorking:(NoNetWork)noNetworking
{
    if (params==nil) {
        params=[NSMutableDictionary dictionary];
    }
    [params setObject:httpMethod forKey:@"HTTP_X_HTTP_METHOD_OVERRIDE"];
    NSString  *baseURLString=[self getSigntureRequestURL:url params:params];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:baseURLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSMutableString *paramsString=[[NSMutableString alloc]init];
    NSArray *keysArray=[params allKeys];
    for (int j=0; j<keysArray.count; j++) {
        [paramsString appendFormat:@"&%@=%@",[keysArray objectAtIndex:j],[params objectForKey:[keysArray objectAtIndex:j]]];
    }
    NSString *finalString=[paramsString substringFromIndex:1];
    NSData *paramsData=[finalString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:paramsData];
    AFHTTPRequestOperationManager *httpManager=[AFHTTPRequestOperationManager manager];
    NSOperationQueue *operationQueue = httpManager.operationQueue;
    [httpManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                noNetworking(@"没有网络连接!");
                break;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    [httpManager.reachabilityManager startMonitoring];
    NSError *error;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error) {
        errorBlock(error);
    }else
    {
        //        NSString *recieveString=[[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
        
        id object=(id)receivedData;
        successblock(object);
    }
}
+(void)requestUpLoadImageurl:(NSString *)url params:(NSMutableDictionary*)params httpMethod:(NSString*)httpMethod imageData:(UIImage*)updateImage fileName:(NSString*)fileName iamgeUrlParams:(NSString*)imageUrlParams successCallBackBlock:(CompletionLoad)successBlock errorBlock:(ErrorBlock)errorBlock noNetworkingBlock:(NoNetWork)noNetWorkingBlock
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://kcwc.luofei.i.ubolixin.com/api/upload/index" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *fileData=UIImagePNGRepresentation(updateImage);
        [formData appendPartWithFileData:fileData name:@"file" fileName:@"testImage.png" mimeType:@"image/jpeg"];
    } error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask= [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            errorBlock(error);
        }else
        {
            ITTAssert([responseObject isKindOfClass:[NSDictionary class]],@"上传图片接口返回的不是字典数据");
            NSString *imageurl=[[responseObject objectForKey:@"data"] objectForKey:@"savename"];
            [params setObject:imageurl forKey:imageUrlParams];
            [self requestAFWithURL:url params:params httpMethod:httpMethod block:successBlock errorBlock:errorBlock noNetWorking:noNetWorkingBlock];
        }
    }];
    [uploadTask resume];
 }
//AFNetworking
+ (void)requestAFWithURL:(NSString *)url
                  params:(NSMutableDictionary *)params
              httpMethod:(NSString *)httpMethod
                   block:(CompletionLoad)successblock
              errorBlock:(ErrorBlock)errorBlock
            noNetWorking:(NoNetWork)noNetworking
{
    if (params==nil) {
        params=[NSMutableDictionary dictionary];
    }
    if ([USER_DEFAULT objectForKey:@"user_token"] !=nil) {
        [params setObject:[USER_DEFAULT objectForKey:@"user_token"] forKey:@"user_token"];
    }
    if ([USER_DEFAULT objectForKey:@"scene_id"] !=nil) {
        [params setObject:[USER_DEFAULT objectForKey:@"scene_id"] forKey:@"scene_id"];
    }
    [params setObject:@"app" forKey:@"request_from"];
//    [params setObject:httpMethod forKey:@"HTTP_X_HTTP_METHOD_OVERRIDE"];
    NSString  *baseURLString=[self getSigntureRequestURL:url params:params];
    AFHTTPRequestOperationManager *httpManager=[AFHTTPRequestOperationManager manager];
    NSOperationQueue *operationQueue = httpManager.operationQueue;
    [httpManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                noNetworking(@"没有网络连接!");
                break;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    [httpManager.reachabilityManager startMonitoring];
    AFHTTPRequestOperation *operation=[httpManager POST:baseURLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"operation.responseString===%@", operation.responseString);
        if (successblock != nil) {
            successblock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (errorBlock != nil) {
        NSLog(@"errorOperation.responseString===%@", operation.responseString);
            errorBlock(error);
        }
    }];
    operation.responseSerializer =[AFJSONResponseSerializer serializer];
}
+ (NSString *)getSigntureRequestURL:(NSString *)api params:(NSMutableDictionary *)params{
     /*
    [params setObject:api forKey:@"_URI_"];
    NSMutableString *paramsString = [NSMutableString string];
    //对params 按key进行排序
    NSArray *keys = [params allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    for (NSString *categoryId in sortedArray) {
        [paramsString appendFormat:@"&%@=%@", categoryId, [params objectForKey:categoryId]];
    }
    NSString *beforeMd5=[paramsString substringFromIndex:1];
    NSString *encodedParams = [FJDataService stringByURLEncodingStringParameter:beforeMd5];
    NSLog(@"beforeMd5😈😈😈😈😈😈😈😈😈😈😈😈=====%@",[NSString stringWithFormat:@"%@test", encodedParams]);
        NSString *signture =[myMd5 md5Encrypt: [NSString stringWithFormat:@"%@test", encodedParams]];
        return [NSString stringWithFormat:@"%@%@?appid=test&signture=%@" , KBaseURL, api, signture];
     */
    NSMutableString *urlString=[[NSMutableString alloc]initWithString:BASICURL];
    [urlString appendString:[NSString stringWithFormat:@"%@?",api]];
    return urlString;
}

+ (NSString*)stringByURLEncodingStringParameter:(NSString *)stt
{
    NSString *resultStr = stt;
    CFStringRef originalString = (__bridge CFStringRef)stt;
    CFStringRef leaveUnescaped = CFSTR(" ");
    CFStringRef forceEscaped = CFSTR("!*'();:@+$,/?%#[]");
    
    CFStringRef escapedStr;
    escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                         originalString,
                                                         leaveUnescaped,
                                                         forceEscaped,
                                                         kCFStringEncodingUTF8);
    
    if( escapedStr )
    {
        NSMutableString *mutableStr = [NSMutableString stringWithString:(__bridge NSString *)escapedStr];
        CFRelease(escapedStr);
        [mutableStr replaceOccurrencesOfString:@" "
                                    withString:@"+"
                                       options:0
                                         range:NSMakeRange(0, [mutableStr length])];
        resultStr = mutableStr;
    }
    return resultStr;
}

@end
