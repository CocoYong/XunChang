//
//  DYCommonCMethod.m
//  DaoYouProject
//
//  Created by 成焱 on 14/12/7.
//  Copyright (c) 2014年 成焱. All rights reserved.
//

#import "DYCommonCMethod.h"

void DYConstrainsSetEdge(UIView *superview, UIView *view,NSLayoutAttribute att,float constant){
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:att relatedBy:NSLayoutRelationEqual toItem:superview attribute:att multiplier:1 constant:constant]];
}
void DYConstrainsSetWidthOrHeight(UIView *view,NSLayoutAttribute att,float constant){
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:att relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant]];
}
void DYConstrains(UIView *superview,UIView *view1,UIView *view2, NSLayoutAttribute att1,NSLayoutAttribute att2,float constant){
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view1 attribute:att1 relatedBy:NSLayoutRelationEqual toItem:view2 attribute:att2 multiplier:1 constant:constant]];
}

void DYStatusBarShow(NSString *status){
    [JDStatusBarNotification showWithStatus:status];
}
void DYStatusBarShowWithDelayDisappear(NSString *status,float delay){
    [JDStatusBarNotification showWithStatus:status dismissAfter:delay];
}
void DYStatusBarShowWithDelayDisappearAndStyle(NSString *status,float delay,NSString *style){
    [JDStatusBarNotification showWithStatus:status dismissAfter:delay styleName:style];
}
