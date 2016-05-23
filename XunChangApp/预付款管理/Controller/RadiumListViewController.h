//
//  RadiumListViewController.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/23.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "BaseViewController.h"
#import "YuFuKuanModel.h"
typedef void(^ChangGuanCallBack)(YuFuKuanDataObjectsModel *objectModel);
@interface RadiumListViewController : BaseViewController
@property(nonatomic,strong)NSArray *objectsArray;
@property(nonatomic,copy) ChangGuanCallBack objectCallBlock;
@end
