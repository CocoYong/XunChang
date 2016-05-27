//
//  ShenBaoSelectItemListViewController.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/10.
//  Copyright © 2016年 zhangyong. All rights reserved.
//  选择项列表

#import "BaseViewController.h"
#import "ShenBaoWorkObjectModel.h"
@interface ShenBaoSelectItemListViewController : BaseViewController
@property(nonatomic,copy)NSString *type_id;
@property(nonatomic,strong)ShenBaoWorkObjectDataObjectsModel *objectModel;
@end
