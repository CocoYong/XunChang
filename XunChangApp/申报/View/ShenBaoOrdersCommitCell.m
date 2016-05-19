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
- (IBAction)timeButtAction:(UIButton *)sender {
    
}
- (IBAction)shenBaoAddNumButtAction:(UIButton *)sender {
    NSInteger objectNum=[self.numLabel.text integerValue];
    CGFloat price=[self.dataModel.price floatValue];
    CGFloat dispost=[self.dataModel.deposit floatValue];
    objectNum++;
    self.numLabel.text=[NSString stringWithFormat:@"%d",objectNum];
    self.feiyongLabel.text=[NSString stringWithFormat:@"￥%.2f",objectNum*price];
    self.yajinTwoLabel.text=[NSString stringWithFormat:@"￥%.2f",objectNum*dispost];
    self.hejiLabel.text=[NSString stringWithFormat:@"￥%.2f",(price+dispost)*objectNum];
    }
- (IBAction)shenBaoMinusButtAction:(UIButton *)sender {
    NSInteger objectNum=[self.numLabel.text integerValue];
    if (objectNum==1) {
        [SVProgressHUD showErrorWithStatus:@"最少选择一件..谢谢" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    CGFloat price=[self.dataModel.price floatValue];
    CGFloat dispost=[self.dataModel.deposit floatValue];
    objectNum--;
    self.numLabel.text=[NSString stringWithFormat:@"%d",objectNum];
    self.feiyongLabel.text=[NSString stringWithFormat:@"￥%.2f",objectNum*price];
    self.yajinTwoLabel.text=[NSString stringWithFormat:@"￥%.2f",objectNum*dispost];
    self.hejiLabel.text=[NSString stringWithFormat:@"￥%.2f",(price+dispost)*objectNum];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
