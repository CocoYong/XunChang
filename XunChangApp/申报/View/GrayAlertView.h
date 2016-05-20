//
//  GrayAlertView.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/19.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ActionBlock)(UIButton *butt);
@interface GrayAlertView : UIView
+(void)showAlertViewWithFirstButtTitle:(NSString*)firstTitle
                       secondButtTitle:(NSString*)secondTitle
                          andAlertText:(NSString*)remmindText
                      remindTitleColor:(UIColor*)titleColor
                     buttOneTitleColor:(UIColor*)buttOneTitleColor
                     buttTwoTitleColor:(UIColor*)buttTwoTitleColor
                buttOneBackGroundColor:(UIColor*)buttOneBackColor
                      buttTwoBackColor:(UIColor*)buttTwoBackColor
                      andCallBackBlock:(ActionBlock)buttBlock;
@end
