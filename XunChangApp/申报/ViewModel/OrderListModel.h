//
//  OrderListModel.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListModel : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,assign)CGFloat totalPayMoney;
@property(nonatomic,strong)NSArray *datas;
@end

@interface OrderListDataModel : NSObject
@property(nonatomic,copy)NSString *checker_realname;
@property(nonatomic,copy)NSString *checker_tel;
@property(nonatomic,copy)NSString *is_comment;
@property(nonatomic,copy)NSString *item_title;
@property(nonatomic,copy)NSString *num;
@property(nonatomic,copy)NSString *object_address;
@property(nonatomic,copy)NSString *object_icon;
@property(nonatomic,copy)NSString *object_id;
@property(nonatomic,copy)NSString *order_num;
@property(nonatomic,copy)NSString *staff_realname;
@property(nonatomic,copy)NSString *realname;
@property(nonatomic,copy)NSString *staff_tel;
@property(nonatomic,copy)NSString *start_time;
@property(nonatomic,copy)NSString *task_status;
@property(nonatomic,copy)NSString *tel;
@property(nonatomic,copy)NSString *total_money;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *type_icon;
@property(nonatomic,copy)NSString *star;
@property(nonatomic,assign)NSInteger checker_user_id;
@property(nonatomic,assign)NSInteger staff_user_id;
@property(nonatomic,assign) BOOL radioButtSelect;
@end