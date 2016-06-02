//
//  ShenBaoSelectItemListViewController.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/10.
//  Copyright © 2016年 zhangyong. All rights reserved.
//  选择项列表

#import "BaseViewController.h"
#import "ShenBaoWorkObjectModel.h"
#import "ShenBaoItemsModel.h"
@interface ShenBaoSelectItemListViewController : BaseViewController
@property(nonatomic,strong)ShenBaoItemDataModel *itemObjectModel;
@property(nonatomic,strong)ShenBaoWorkObjectDataObjectsModel *objectModel;
@end
