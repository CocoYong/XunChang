//
//  myMd5.m
//  MaiHome
//
//  Created by toge on 15/7/27.
//  Copyright (c) 2015年 toge. All rights reserved.
//

#import "myMd5.h"
 #import<CommonCrypto/CommonDigest.h>

@implementation myMd5


+ (NSString *)md5Encrypt:(NSString *)str {
    
    const char *original_str = [str UTF8String];
    
    char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), (unsigned char *)result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02x", (unsigned char)result[i]];
    
    return [hash lowercaseString];
}



@end
