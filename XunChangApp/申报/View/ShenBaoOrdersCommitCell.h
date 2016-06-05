//
//  ShenBaoOrdersCommitCell.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/19.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShenBaoKemuModel.h"
#import "ShenBaoOrdersCommitViewController.h"
@interface ShenBaoOrdersCommitCell : UITableViewCell<UITextFieldDelegate>
//two
@property(nonatomic,strong)ShenBaoKemuDataModel *dataModel;
@property(nonatomic,strong)ShenBaoOrdersCommitViewController *superController;
@property (weak, nonatomic) IBOutlet UITextField *numTextfield;
@property (weak, nonatomic) IBOutlet UIButton *minusButt;
@property (weak, nonatomic) IBOutlet UIButton *addButt;

//three
@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

//five
@property (weak, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTextField;
@property (weak, nonatomic) IBOutlet UIButton *startTimeButt;
@property (weak, nonatomic) IBOutlet UIButton *endTimeButt;

//eight
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemDetailLabel;


@end
