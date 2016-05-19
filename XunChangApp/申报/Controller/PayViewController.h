//
//  PayViewController.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/11.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "BaseViewController.h"
#import "ShenBaoKemuModel.h"
@interface PayViewController : BaseViewController
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,copy)NSString *orderNum;
@property(nonatomic,strong)ShenBaoKemuDataModel *dataModel;
@end
