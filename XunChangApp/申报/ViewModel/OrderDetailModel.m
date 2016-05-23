//
//  OrderDetailModel.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/19.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel

@end
@implementation OrderDetailDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"progressArray" : [OrderDetailDataProgressModel class],@"serviceFileArray" : [OrderDetailDataServiceFileModel class]};
}
@end
@implementation OrderDetailDataProgressModel
@end
@implementation OrderDetailDataServiceFileModel

@end