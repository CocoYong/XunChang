//
//  BaseViewController.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/5.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
-(void)createNavBackButt;
-(void)setNavBarColor:(UIColor*)color;
-(void)backToFrontViewController;
-(NSMutableAttributedString*)createAttributStringWithString:(NSString*)originalString changeString:(NSString*)specialString andAttributDic:(NSDictionary*)attributDic;
-(void)dialTelephoneWithTelephoneNum:(NSString*)telNum;
@end
