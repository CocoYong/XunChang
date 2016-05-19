//
//  myMd5.h
//  MaiHome
//
//  Created by toge on 15/7/27.
//  Copyright (c) 2015年 toge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myMd5 : NSObject

+ (NSString *)md5Encrypt:(NSString *)str;


//拼接
+ (NSString *)md5Encrypt:(NSString *)str  frontString:(NSString *)frontString;




@end
