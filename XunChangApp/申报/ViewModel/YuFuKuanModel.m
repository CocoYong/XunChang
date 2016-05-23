//
//  YuFuKuanModel.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "YuFuKuanModel.h"

@implementation YuFuKuanModel

@end
@implementation YuFuKuanDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"listsArray" : [YuFuKuanDataListsModel class],@"objectsArray" : [YuFuKuanDataObjectsModel class]};
}
@end

@implementation YuFuKuanDataListsModel



@end

@implementation YuFuKuanDataObjectsModel



@end