//
//  OrderListCell.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/11.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "OrderListCell.h"

@implementation OrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cancelButt.layer.cornerRadius=3.0f;
    self.cancelButt.layer.borderColor=[UIColor colorWithHexString:@"#DADBDC"].CGColor;
    self.cancelButt.layer.borderWidth=1.0f;
    self.deletButt.layer.borderColor=[UIColor colorWithHexString:@"#DADBDC"].CGColor;
    self.deletButt.layer.borderWidth=1.0f;
    self.payButt.layer.cornerRadius=3.0f;
    self.contentBackView.layer.borderColor=[UIColor colorWithHexString:@"#F4F5F6"].CGColor;
    self.contentBackView.layer.borderWidth=1.0f;
      [self.radioButt setImage:[UIImage imageNamed:@"radio_selected"] forState:UIControlStateSelected];
     [self.radioButt setImage:[UIImage imageNamed:@"radio_normal"] forState:UIControlStateNormal];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
