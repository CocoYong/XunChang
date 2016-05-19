//
//  OrderDetailCell.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/12.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "HCSStarRatingView.h"
@interface OrderDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *changGuanIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *objectIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *objectDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *changGuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *objectCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *useMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dispositMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
//two
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
//three
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *telephoneButt;
@property (weak, nonatomic) IBOutlet UILabel *userTypeLabel;

//four
@property (weak, nonatomic) IBOutlet UILabel *completEvidenceTimeLabel;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *placeHolderViewFour;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageViewFour;
//five
@property (weak, nonatomic) IBOutlet UIView *starBackView;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *placeHoldViewFive;
//six
@property (weak, nonatomic) IBOutlet UILabel *orderActionLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderActionTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderActionInfoLabel;


@end
