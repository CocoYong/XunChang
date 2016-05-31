//
//  ShenBaoWorkObjectModel.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShenBaoWorkObjectModel : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong)NSArray *datas;
@end

@interface ShenBaoWorkObjectDataModel : NSObject
@property(nonatomic,copy)NSString *area_name;
@property(nonatomic,strong)NSArray *objects;
@end

@interface ShenBaoWorkObjectDataObjectsModel : NSObject
@property(nonatomic,copy)NSString *owner_icon;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *area_id;
@property(nonatomic,copy)NSString *owner_type;
@property(nonatomic,copy)NSString *owner_title;
@property(nonatomic,assign)CGFloat square;
@end