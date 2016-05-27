//
//  ShenBaoKemuModel.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShenBaoKemuModel : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong)NSArray *datas;
@end
@interface ShenBaoKemuDataModel : NSObject
@property(nonatomic,copy)NSString *deposit_money;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *intro;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *scene_id;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *order_title;
@property(nonatomic,copy)NSString *type_id;
@property(nonatomic,copy)NSString *unit;
@property(nonatomic,assign)BOOL select;
@property(nonatomic,copy)NSString *object_num; //物品数量临时存储用 非url返回字段
@property(nonatomic,copy)NSString *order_num; //订单号临时存储用...非url返回字段
@end