//
//  UserCenterModel.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "UserCenterModel.h"

@implementation UserCenterModel

@end
@implementation UserCenterDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"actions" : [ActionsModel class],@"scenes":[ScenesModel class]};
}

@end

@implementation ScenesModel

@end

@implementation UserInfo

@end
@implementation ActionsModel

@end