//
//  OrderListModel.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datas" : [OrderListDataModel class]};
}
@end
@implementation OrderListDataModel
@end