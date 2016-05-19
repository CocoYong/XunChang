//
//  ShenBaoLeixingModel.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "ShenBaoItemsModel.h"
@implementation ShenBaoItemsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datas" : [ShenBaoItemDataModel class]};
}
@end

@implementation ShenBaoItemDataModel
@end