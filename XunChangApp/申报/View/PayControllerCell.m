//
//  PayControllerCell.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/19.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "PayControllerCell.h"

@implementation PayControllerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.yuFuKuanButt setImage:[UIImage imageNamed:@"radio_normal"] forState:UIControlStateNormal];
    [self.yuFuKuanButt setImage:[UIImage imageNamed:@"radio_selected"] forState:UIControlStateSelected];
    [self.weiXinButt setImage:[UIImage imageNamed:@"radio_normal"] forState:UIControlStateNormal];
    [self.weiXinButt setImage:[UIImage imageNamed:@"radio_selected"] forState:UIControlStateSelected];
    [self.offLineButt setImage:[UIImage imageNamed:@"radio_normal"] forState:UIControlStateNormal];
    [self.offLineButt setImage:[UIImage imageNamed:@"radio_selected"] forState:UIControlStateSelected];
    // Initialization code
}
- (IBAction)yuFuKuanButtAction:(UIButton *)sender {
    if (self.weiXinButt.selected) {
        self.weiXinButt.selected=NO;
        sender.selected=YES;
    }
}
- (IBAction)weiXinButtAction:(UIButton *)sender {
    if (self.yuFuKuanButt.selected) {
        self.yuFuKuanButt.selected=NO;
        sender.selected=YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
