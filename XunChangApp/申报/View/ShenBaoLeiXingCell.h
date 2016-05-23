//
//  ShenBaoLeiXingCell.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/11.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShenBaoLeiXingCell : UITableViewCell
//申报类型Cell
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//场景tablecell
@property (weak, nonatomic) IBOutlet UIImageView *changJingImageView;
@property (weak, nonatomic) IBOutlet UILabel *changJIngNameLabel;

//uploadserviceEvidenceTableCell
@property (weak, nonatomic) IBOutlet UIImageView *uploadServiceImageView;
@property (weak, nonatomic) IBOutlet UILabel *uploadServiceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *uploadServiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *uploadServiceButt;
@property (weak, nonatomic) IBOutlet UILabel *uploadServiceSizeLabel;


//yufukuanCellOne
@property (weak, nonatomic) IBOutlet UIImageView *yuFuKuanRadiumImageView;
@property (weak, nonatomic) IBOutlet UILabel *yuFuKuanRadiumNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *yuFuKuanButt;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *useMoneyLabel;
//yufukuanCellTwo
@property (weak, nonatomic) IBOutlet UILabel *yuFuKuanTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *yuFuKuanObjectImageView;
@property (weak, nonatomic) IBOutlet UILabel *useMoneyDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuFuKuanTimeLabel;



@end
