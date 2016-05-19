//
//  BaseViewController+CommonFuncs.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/14.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (CommonFuncs)
- (BOOL)validateEmail:(NSString *)emailString;
- (BOOL)validateHasTheChineseSpecialCharacter:(NSString *)string;
- (BOOL)validateMobile:(NSString *)mobileNum;
- (BOOL)validatePhoneMobile:(NSString *)mobileNum;
- (BOOL)validateIDCardNumber:(NSString *)value;
@end
