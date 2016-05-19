//
//  HomeCollectionViewItemCell.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/12.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "HomeCollectionViewItemCell.h"
@implementation HomeCollectionViewItemCell
-(void)awakeFromNib
{
    self.messageNumLabel.layer.masksToBounds=YES;
    self.messageNumLabel.layer.cornerRadius=6.0f;
}
@end
