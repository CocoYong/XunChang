//
//  MoneyModel.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/18.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MoneyDataModel;
@interface MoneyModel : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,strong)MoneyDataModel *data;
@property(nonatomic,copy)NSString *message;
@end

@interface MoneyDataModel : NSObject
@property(nonatomic,copy)NSString *deposit_money;
@property(nonatomic,copy)NSString *money;
@property(nonatomic,copy)NSString *paid_money;
@property(nonatomic,copy)NSString *use_money;
@end