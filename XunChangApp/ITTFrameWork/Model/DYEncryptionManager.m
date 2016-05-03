//
//  DYEncryptionManager.m
//  DaoYouProject
//
//  Created by 成焱 on 15-2-3.
//  Copyright (c) 2015年 成焱. All rights reserved.
//

#import "DYEncryptionManager.h"

@implementation DYEncryptionManager
+ (DYEncryptionResult *)encryptionWithURL:(NSString *)url parameters:(NSDictionary *)param{
    
//    //1.将获取到参数，先做一个排序。
//    NSArray *allKeys = [param allKeys];
//    NSArray *sortKeys = [DYEncryptionManager sortKeys:allKeys];
//    //2.然后做一个签名
//    NSMutableString *signString = [NSMutableString stringWithString:@""];
//    NSMutableArray *theKeys = [NSMutableArray arrayWithArray:sortKeys];
////    for (NSString *key in theKeys) {
////        if ([key isEqualToString:@"appid"]) {
////            [theKeys removeObject:key];
////        }
////    }
//    [theKeys removeObject:@"appid"];
//    for (NSString *key in param) {
//        if (![[param valueForKey:key]isKindOfClass:[NSString class]]) {
//            [theKeys removeObject:key];
//        }
//    }
//    for (int i = 0; i<[theKeys count]; i++) {
//
//        NSString *key = [theKeys objectAtIndex:i];
//        NSString *value = [param valueForKey:key];
//
//        if ([value isKindOfClass:[NSString class]]) {
//            //将图片类型的值过滤掉
//            [signString appendString:[key encodeUrl]];
//            [signString appendString:@"="];
//            [signString appendString:[value encodeUrl]];
//        }
//        if(i!=[theKeys count]-1){
//            [signString appendString:@"&"];
//        }
//    }
//    [signString appendString:DYAppKey];
//    signString = (NSMutableString *)[signString stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
//    NSLog(@"signstring = %@",signString);
//    signString = (NSMutableString *)[signString md5];
//    //3.找到_URI_串，然后将其替换为签名串
//    NSString *value = [NSString stringWithFormat:@"%@",signString];
//    [param setValue:nil forKey:@"_URI_"];
//    [param setValue:nil forKey:@"appid"];
//    
    DYEncryptionResult *result = [DYEncryptionResult new];
    result.url = [url stringByAppendingString:[NSString stringWithFormat:@"appid=%@&signture=%@",@"sdad",@"dfsfjsl"]];
    result.param = param;
    
    NSLog(@"---%@",result);
    return result;
}

+ (NSArray *)sortKeys:(NSArray *)keys
{
    if ([keys isKindOfClass:[NSArray class]]&&[keys count]>0) {
        NSArray *des = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            return [obj1 compare:obj2];
        }];
        return des;
    }else
        return nil;
}
@end

@implementation DYEncryptionResult

- (id)init{
    if (self== [super init]) {
        
    }
    return self;
}

- (NSString *)description{
    NSString *prefixString = @"\n*****************************************************************************\n";
    NSString *url = [NSString stringWithFormat:@"\n\t\t\t\t您访问的Url为:\n%@",self.url];
    NSMutableString *params = [NSMutableString string];
    [params appendString:prefixString];
    [params appendString:url];
    [params appendString:@"\n"];
    [params appendString:@"\t\t\t\t您访问的参数列表为:\n"];
    for (NSString *key in [self.param allKeys]) {
        [params appendString:key];
        [params appendString:@":"];
        if([[self.param valueForKey:key]isKindOfClass:[NSString class]]){
            [params appendString:[self.param valueForKey:key]];
        }
        [params appendString:@"\n"];
    }
    [params appendString:[NSString stringWithFormat:@"*****************************************************************************\n"]];
    return params;
}

@end