//
//  ShenBaoWorkObjectModel.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "ShenBaoWorkObjectModel.h"

@implementation ShenBaoWorkObjectModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datas" : [ShenBaoWorkObjectDataModel class]};
}
@end
@implementation ShenBaoWorkObjectDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"objects" : [ShenBaoWorkObjectDataObjectsModel class]};
}
@end
@implementation ShenBaoWorkObjectDataObjectsModel
@end