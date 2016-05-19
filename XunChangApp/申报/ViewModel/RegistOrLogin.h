//
//  RegistOrLogin.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DataModel;
@interface RegistOrLogin : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong) DataModel*data;
@end

@interface DataModel : NSObject
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *isBind;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *user_token;
@end