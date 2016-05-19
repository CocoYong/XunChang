//
//  ShenBaoKemuModel.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "ShenBaoKemuModel.h"

@implementation ShenBaoKemuModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datas" : [ShenBaoKemuDataModel class]};
}
@end
@implementation ShenBaoKemuDataModel
@end