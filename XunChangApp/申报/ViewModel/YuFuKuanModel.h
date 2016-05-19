//
//  YuFuKuanModel.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YuFuKuanModel : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong)NSArray *datas;
@end

@interface YuFuKuanDataModel : NSObject
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *object_id;
@property(nonatomic,copy)NSString *realname;
@property(nonatomic,copy)NSString *scene_id;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *user_id;
@end