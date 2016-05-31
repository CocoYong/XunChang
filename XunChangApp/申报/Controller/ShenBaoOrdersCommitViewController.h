//
//  ShenBaoOrdersCommitViewController.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/10.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "BaseViewController.h"
#import "ShenBaoKemuModel.h"
#import "ShenBaoWorkObjectModel.h"
@interface ShenBaoOrdersCommitViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)ShenBaoKemuDataModel *dataModel;
@property(nonatomic,strong)ShenBaoWorkObjectDataObjectsModel *objectModel;
@property(nonatomic,copy)NSString *object_id;
@end
