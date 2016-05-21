//
//  ChangJingViewController.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/10.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "BaseViewController.h"
#import "UserCenterModel.h"
typedef void(^ChangJingCallBack)(ScenesModel *sceneModel);
@interface ChangJingViewController : BaseViewController
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,copy)ChangJingCallBack sceneBlock;
@end
