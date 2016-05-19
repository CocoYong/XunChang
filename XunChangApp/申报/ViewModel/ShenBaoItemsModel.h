//
//  ShenBaoLeixingModel.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShenBaoItemDataModel;
@interface ShenBaoItemsModel : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong) NSArray *datas;
@end


@interface ShenBaoItemDataModel : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *title;
@end