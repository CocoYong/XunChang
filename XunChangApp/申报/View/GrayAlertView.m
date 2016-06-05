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
    //弹出框
    UIView *alertView=[[UIView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-80, SCREEN_WIDTH-60, 160)];
    alertView.backgroundColor=[UIColor whiteColor];
    alertView.layer.borderColor=[UIColor colorWithHexString:@"#E4E4E4"].CGColor;
    alertView.layer.cornerRadius=3.0f;
    
    
    UIView *horiLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 119, SCREEN_WIDTH-60, 1)];
    horiLineView.backgroundColor=[UIColor colorWithHexString:@"#e0e0e0"];
    [alertView addSubview:horiLineView];
    
    UIView *vetaLineView=[[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2-0.5, 120, 1, 40)];
    vetaLineView.backgroundColor=[UIColor colorWithHexString:@"#e0e0e0"];
    [alertView addSubview:vetaLineView];
    
    //第一个按钮
    UIButton *buttOne=[UIButton buttonWithType:UIButtonTypeCustom];
    buttOne.frame=CGRectMake(0, 120, (SCREEN_WIDTH-60)/2-0.5, 40);
    buttOne.layer.cornerRadius=3.0f;
    buttOne.titleLabel.font=[UIFont systemFontOfSize:18];
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
    //第二个按钮
    UIButton *buttTwo=[UIButton buttonWithType:UIButtonTypeCustom];
    buttTwo.frame=CGRectMake((SCREEN_WIDTH-60)/2+0.5, 120, (SCREEN_WIDTH-60)/2, 40);
    buttTwo.titleLabel.font=[UIFont systemFontOfSize:18];
    [buttTwo setTitle:secondTitle forState:UIControlStateNormal];
    [buttTwo setTitleColor:buttTwoTitleColor forState:UIControlStateNormal];
    buttTwo.layer.cornerRadius=3.0f;
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
    
    //关闭按钮
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
