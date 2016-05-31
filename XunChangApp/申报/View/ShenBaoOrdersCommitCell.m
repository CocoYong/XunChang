//
//  ShenBaoOrdersCommitCell.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/19.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "ShenBaoOrdersCommitCell.h"

@implementation ShenBaoOrdersCommitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.borderColor=[UIColor colorWithHexString:@"#ECEDEE"].CGColor;
    self.backView.layer.borderWidth=1.0f;
}
- (IBAction)shenBaoAddNumButtAction:(UIButton *)sender {
    NSInteger objectNum=[self.numLabel.text integerValue];
    CGFloat price=[self.dataModel.price floatValue];
    CGFloat dispost=[self.dataModel.deposit_money floatValue];
    objectNum++;
    self.numLabel.text=[NSString stringWithFormat:@"%d",objectNum];
    self.dataModel.object_num=self.numLabel.text;
    if (self.dataModel.hasSquare) {
        self.dataModel.feiyong_money=[NSString stringWithFormat:@"￥%.2f",self.dataModel.squareNum*objectNum*price];
        self.dataModel.yajin_money=[NSString stringWithFormat:@"￥%.2f",objectNum*dispost];
        self.dataModel.total_money=[NSString stringWithFormat:@"￥%.2f",(self.dataModel.squareNum*price+dispost)*objectNum];
    }else
    {
        self.dataModel.feiyong_money=[NSString stringWithFormat:@"￥%.2f",objectNum*price];
        self.dataModel.yajin_money=[NSString stringWithFormat:@"￥%.2f",objectNum*dispost];
        self.dataModel.total_money=[NSString stringWithFormat:@"￥%.2f",(price+dispost)*objectNum];
    }
    [self.superController.tableView reloadData];
}
- (IBAction)shenBaoMinusButtAction:(UIButton *)sender {
    NSInteger objectNum=[self.numLabel.text integerValue];
    if (objectNum==1) {
        [SVProgressHUD showErrorWithStatus:@"最少选择一件..谢谢" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    CGFloat price=[self.dataModel.price floatValue];
    CGFloat dispost=[self.dataModel.deposit_money floatValue];
    objectNum--;
    self.numLabel.text=[NSString stringWithFormat:@"%d",objectNum];
    self.dataModel.object_num=self.numLabel.text;
    if (self.dataModel.hasSquare) {
        self.dataModel.feiyong_money=[NSString stringWithFormat:@"￥%.2f",self.dataModel.squareNum*objectNum*price];
        self.dataModel.yajin_money=[NSString stringWithFormat:@"￥%.2f",objectNum*dispost];
        self.dataModel.total_money=[NSString stringWithFormat:@"￥%.2f",(self.dataModel.squareNum*price+dispost)*objectNum];
    }else
    {
        self.dataModel.feiyong_money=[NSString stringWithFormat:@"￥%.2f",objectNum*price];
        self.dataModel.yajin_money=[NSString stringWithFormat:@"￥%.2f",objectNum*dispost];
        self.dataModel.total_money=[NSString stringWithFormat:@"￥%.2f",(price+dispost)*objectNum];
    }
    [self.superController.tableView reloadData];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
