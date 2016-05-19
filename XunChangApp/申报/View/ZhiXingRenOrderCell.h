//
//  ZhiXingRenOrderCell.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/18.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
@interface ZhiXingRenOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *changGuanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *objectImageView;
@property (weak, nonatomic) IBOutlet UILabel *changGuanNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *objectDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *objectNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shenBaoRenLabel;
@property (weak, nonatomic) IBOutlet UIView *starBackView;
@property (weak, nonatomic) IBOutlet UILabel *serviceEvaluateLabel;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *telephoneButt;

@property (weak, nonatomic) IBOutlet UIButton *statusButt;

@end
