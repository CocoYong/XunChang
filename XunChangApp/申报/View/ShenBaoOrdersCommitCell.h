//
//  ShenBaoOrdersCommitCell.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/19.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShenBaoKemuModel.h"
@interface ShenBaoOrdersCommitCell : UITableViewCell
//one
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *keMuLabel;
@property (weak, nonatomic) IBOutlet UILabel *danweiLabel;
@property (weak, nonatomic) IBOutlet UILabel *danjiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *yajinLabel;
@property (weak, nonatomic) IBOutlet UILabel *shuomingLabel;

//two
@property(nonatomic,strong)ShenBaoKemuDataModel *dataModel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *feiyongLabel;
@property (weak, nonatomic) IBOutlet UILabel *yajinTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *hejiLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusButt;
@property (weak, nonatomic) IBOutlet UIButton *addButt;

//three
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
//four
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
//five
@property (weak, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTextField;
@property (weak, nonatomic) IBOutlet UIButton *startTimeButt;
@property (weak, nonatomic) IBOutlet UIButton *endTimeButt;

//six
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumTextfield;
//seven
@property (weak, nonatomic) IBOutlet UITextField *carNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *sendGoodsTextfield;
@property (weak, nonatomic) IBOutlet UITextField *goinTimeTextfield;
//eight
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemDetailLabel;


@end
