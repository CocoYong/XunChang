//
//  CreateOrderModel.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/18.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CreateOrderDataModel;
@interface CreateOrderModel : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,strong)CreateOrderDataModel *data;
@property(nonatomic,copy)NSString *message;
@end
@interface CreateOrderDataModel : NSObject
@property(nonatomic,copy)NSString *order_num;
@end