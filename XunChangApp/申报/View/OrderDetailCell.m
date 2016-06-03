//
//  OrderDetailCell.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/12.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "OrderDetailCell.h"

@implementation OrderDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.buttonTwo.layer.cornerRadius=3.0f;
    self.buttonTwo.layer.borderColor=[UIColor colorWithHexString:@"#DADBDC"].CGColor;
    self.buttonTwo.layer.borderWidth=1.0f;
    self.buttOne.layer.borderColor=[UIColor colorWithHexString:@"#DADBDC"].CGColor;
    self.buttOne.layer.borderWidth=1.0f;
    self.buttOne.layer.cornerRadius=3.0f;
    self.buttonThree.layer.cornerRadius=3.0f;
    self.photoImageView.layer.cornerRadius=20;
    self.photoImageView.layer.masksToBounds=YES;
}
-(void)updateConstraints
{
    [super updateConstraints];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
