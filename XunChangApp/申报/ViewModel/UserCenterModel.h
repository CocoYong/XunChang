//
//  UserCenterModel.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfo,UserCenterDataModel;
@interface UserCenterModel : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong)UserCenterDataModel *data;
@end
@interface UserCenterDataModel : NSObject
@property(nonatomic,strong)NSArray *actions;
@property(nonatomic,copy)NSString *scene_icon;
@property(nonatomic,copy)NSString *scene_id;
@property(nonatomic,copy)NSString *scene_title;
@property(nonatomic,strong)NSArray *scenes;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,strong)UserInfo *userinfo;

@end

@interface UserInfo : NSObject
@property(nonatomic,copy)NSString *avatar;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *tel;
@end

@interface ScenesModel : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *is_selected;
@property(nonatomic,copy)NSString *title;
@end

@interface ActionsModel : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *message_count;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *title;
@end