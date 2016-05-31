//
//  OrderDetailModel.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/19.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderDetailDataModel;
@interface OrderDetailModel : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,strong)OrderDetailDataModel *data;
@property(nonatomic,copy)NSString *message;
@end

@interface OrderDetailDataModel : NSObject
@property(nonatomic,copy)NSString *apply_type_id;
@property(nonatomic,copy)NSString *avatar;
@property(nonatomic,copy)NSString *cancel_time;
@property(nonatomic,copy)NSString *checker_avatar;
@property(nonatomic,copy)NSString *checker_realname;
@property(nonatomic,copy)NSString *checker_tel;
@property(nonatomic,copy)NSString *checker_user_id;
@property(nonatomic,copy)NSString *comment;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *deposit_money;
@property(nonatomic,copy)NSString *end_time;
@property(nonatomic,copy)NSString *finish_time;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *item_id;
@property(nonatomic,copy)NSString *item_title;
@property(nonatomic,copy)NSString *num;
@property(nonatomic,copy)NSString *object_address;
@property(nonatomic,copy)NSString *object_icon;
@property(nonatomic,copy)NSString *object_id;
@property(nonatomic,copy)NSString *order_num;
@property(nonatomic,copy)NSString *paid_time;
@property(nonatomic,copy)NSString *pay_type;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *realname;
@property(nonatomic,copy)NSString *scene_id;
@property(nonatomic,copy)NSString *service_message;
@property(nonatomic,strong)NSArray *serviceFileArray;//
@property(nonatomic,copy)NSString *show_comment;
@property(nonatomic,copy)NSString *show_guest;
@property(nonatomic,copy)NSString *show_service;
@property(nonatomic,copy)NSString *show_staff;
@property(nonatomic,copy)NSString *sign_time;
@property(nonatomic,copy)NSString *staff_avatar;
@property(nonatomic,copy)NSString *staff_realname;
@property(nonatomic,copy)NSString *staff_tel;
@property(nonatomic,copy)NSString *staff_user_id;
@property(nonatomic,assign)NSInteger star;
@property(nonatomic,copy)NSString *start_time;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *task_status;
@property(nonatomic,copy)NSString *tel;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *total_deposit_money;
@property(nonatomic,copy)NSString *total_money;
@property(nonatomic,copy)NSString *total_use_money;
@property(nonatomic,copy)NSString *type_icon;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,assign)CGFloat square;
@property(nonatomic,strong)NSArray *progressArray;
@end

@interface OrderDetailDataProgressModel : NSObject
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *scene_id;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *type;
@end

@interface OrderDetailDataServiceFileModel : NSObject
@property(nonatomic,copy)NSString *filename;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *size;
@property(nonatomic,strong)NSArray *imageUrlArray;
@end