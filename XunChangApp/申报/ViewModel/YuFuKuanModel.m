//
//  YuFuKuanModel.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "YuFuKuanModel.h"

@implementation YuFuKuanModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datas" : [YuFuKuanDataModel class]};
}
@end
@implementation YuFuKuanDataModel
@end