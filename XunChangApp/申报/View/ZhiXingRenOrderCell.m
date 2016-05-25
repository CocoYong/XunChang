//
//  ZhiXingRenOrderCell.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/18.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "ZhiXingRenOrderCell.h"

@implementation ZhiXingRenOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.statusButt.layer.cornerRadius=3.0f;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
