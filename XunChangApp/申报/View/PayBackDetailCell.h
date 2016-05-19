//
//  PayBackDetailCell.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/19.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayBackDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;


@property (weak, nonatomic) IBOutlet UIButton *stateButt;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *payBackTitleLabel;


@property (weak, nonatomic) IBOutlet UILabel *moneyNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *paybackTimeLabel;


@property (weak, nonatomic) IBOutlet UIImageView *shenFenPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rowOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *rowTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *rowThreeLabel;
@end
