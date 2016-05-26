//
//  YuFuKuanModel.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YuFuKuanDataModel,YuFuKuanDataListsModel,YuFuKuanDataObjectsModel;
@interface YuFuKuanModel : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong)YuFuKuanDataModel *data;
@end


@interface YuFuKuanDataModel : NSObject
@property(nonatomic,strong)NSArray *listsArray;
@property(nonatomic,copy)NSString *money;
@property(nonatomic,copy)NSString *object_icon;
@property(nonatomic,copy)NSString *object_id;
@property(nonatomic,copy)NSString *object_title;
@property(nonatomic,strong)NSArray *objectsArray;
@property(nonatomic,copy)NSString *paid_money;
@end


@interface YuFuKuanDataListsModel : NSObject
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *object_id;
@property(nonatomic,copy)NSString *realname;
@property(nonatomic,copy)NSString *scene_id;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *money;
@end

@interface  YuFuKuanDataObjectsModel: NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *object_title;
@property(nonatomic,copy)NSString *is_selected;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *money;
@end