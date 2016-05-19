//
//  UIPlaceHolderTextView.h
//  MaiHome
//
//  Created by MrZhang on 15/5/29.
//  Copyright (c) 2015年 ZhangYong. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface UIPlaceHolderTextView : UITextView
{
    NSString *placeHolder;
    UIColor *placeholderColor;
    @private
    UILabel *placeHolderLabel;
}
@property(nonatomic)IBInspectable UILabel *placeHolderLabel;
@property(nonatomic)IBInspectable NSString *placeholder;
@property(nonatomic)IBInspectable UIColor *placeholderColor;
-(instancetype)initWithFrame:(CGRect)frame andPlaceholder:(NSString*)placeholder andLayerRadius:(CGFloat)radius andBorderColor:(UIColor*)color andBorderWidth:(CGFloat)width;
@end
