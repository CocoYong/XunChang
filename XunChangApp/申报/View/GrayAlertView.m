//
//  GrayAlertView.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/19.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "GrayAlertView.h"
@interface GrayAlertView()
//@property(nonatomic,copy)ActionBlock buttBlock;
@end
@implementation GrayAlertView

+(void)showAlertViewWithFirstButtTitle:(NSString*)firstTitle
                       secondButtTitle:(NSString*)secondTitle
                          andAlertText:(NSString*)remmindText
                      remindTitleColor:(UIColor*)titleColor
                     buttOneTitleColor:(UIColor*)buttOneTitleColor
                     buttTwoTitleColor:(UIColor*)buttTwoTitleColor
                buttOneBackGroundColor:(UIColor*)buttOneBackColor
                      buttTwoBackColor:(UIColor*)buttTwoBackColor
                      andCallBackBlock:(ActionBlock)buttBlock
{
    UIWindow *appWindow=[UIApplication sharedApplication].keyWindow;
    //半透明黑色背景
    UIView *backGrayView=[[self alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backGrayView.backgroundColor=[UIColor darkGrayColor];
    backGrayView.alpha=0.5;
    [appWindow addSubview:backGrayView];
    
    UIView *alertView=[[UIView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-80, SCREEN_WIDTH-60, 160)];
    alertView.backgroundColor=[UIColor whiteColor];
    alertView.layer.borderColor=[UIColor colorWithHexString:@"#E4E4E4"].CGColor;
    alertView.layer.cornerRadius=3.0f;
    
    UIButton *buttOne=[UIButton buttonWithType:UIButtonTypeCustom];
    buttOne.frame=CGRectMake(20, 110, 80, 30);
    buttOne.titleLabel.font=[UIFont systemFontOfSize:13];
    buttOne.tag=1;
    buttOne.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        [alertView removeFromSuperview];
        [backGrayView removeFromSuperview];
        buttBlock(buttOne);
        return [RACSignal empty];
    }];
    [buttOne setTitle:firstTitle forState:UIControlStateNormal];
    [buttOne setTitleColor:buttOneTitleColor forState:UIControlStateNormal];
    buttOne.backgroundColor=buttOneBackColor;
    [alertView addSubview:buttOne];
    
    UIButton *buttTwo=[UIButton buttonWithType:UIButtonTypeCustom];
    buttTwo.frame=CGRectMake(SCREEN_WIDTH-160, 110, 80, 30);
    buttTwo.titleLabel.font=[UIFont systemFontOfSize:13];
    [buttTwo setTitle:secondTitle forState:UIControlStateNormal];
    [buttTwo setTitleColor:buttTwoTitleColor forState:UIControlStateNormal];
    buttTwo.backgroundColor=buttTwoBackColor;
    buttTwo.tag=2;
    buttTwo.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        [alertView removeFromSuperview];
        [backGrayView removeFromSuperview];
        buttBlock(buttTwo);
        return [RACSignal empty];
    }];
    [alertView addSubview:buttTwo];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH-100, 50)];
    label.text=remmindText;
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=titleColor;
    [alertView addSubview:label];
    
    
    UIButton *closedButt=[UIButton buttonWithType:UIButtonTypeCustom];
    closedButt.frame=CGRectMake(CGRectGetWidth(alertView.frame)-30, 10, 20, 20);
    [closedButt setImage:[UIImage imageNamed:@"cion_sc"] forState:UIControlStateNormal];
    closedButt.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        [alertView removeFromSuperview];
        [backGrayView removeFromSuperview];
        return [RACSignal empty];
    }];
    [alertView addSubview:closedButt];
    [appWindow addSubview:alertView];
}
+(void)showAlertViewWithFirstButtTitle:(NSString*)firstTitle
                       secondButtTitle:(NSString*)secondTitle
                          andAlertText:(NSString*)remmindText
                      remindTitleColor:(UIColor*)titleColor
                     buttOneTitleColor:(UIColor*)buttOneTitleColor
                     buttTwoTitleColor:(UIColor*)buttTwoTitleColor
                buttOneBackGroundColor:(UIColor*)buttOneBackColor
                      buttTwoBackColor:(UIColor*)buttTwoBackColor
                             andTarget:(id)target
                       buttOneSelector:(SEL)selectorOne
                       ButtTwoSelector:(SEL)selectorTwo
                    cancalButtSelector:(SEL)cancelSelector
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
