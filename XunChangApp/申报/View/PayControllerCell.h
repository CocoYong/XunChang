//
//  PayControllerCell.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/19.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayControllerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderDetailLabel;


@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *yuFuKuanButt;
@property (weak, nonatomic) IBOutlet UIButton *weiXinButt;
@property (weak, nonatomic) IBOutlet UIButton *offLineButt;


@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@end
