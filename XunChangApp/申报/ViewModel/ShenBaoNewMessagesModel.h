//
//  ShenBaoNewMessagesModel.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/15.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShenBaoNewMessageDataModel;
@interface ShenBaoNewMessagesModel : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong)ShenBaoNewMessageDataModel *data;
@end
@interface ShenBaoNewMessageDataModel : NSObject
@property(nonatomic,assign)NSInteger pending_comment_count;
@property(nonatomic,assign)NSInteger pending_confirm_count;
@property(nonatomic,assign)NSInteger pending_pay_count;
@property(nonatomic,assign)NSInteger pending_server_count;
@end