//
//  DYCommonCMethod.h
//  DaoYouProject
//
//  Created by 成焱 on 14/12/7.
//  Copyright (c) 2014年 成焱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDStatusBarNotification.h"
extern void DYConstrains(UIView *superview,UIView *view1,UIView *view2, NSLayoutAttribute att1,NSLayoutAttribute att2,float constant);
extern void DYConstrainsSetEdge(UIView *superview, UIView *view,NSLayoutAttribute att,float constant);
extern void DYConstrainsSetWidthOrHeight(UIView *view,NSLayoutAttribute att,float constant);
extern void DYStatusBarShow(NSString *status);
extern void DYStatusBarShowWithDelayDisappear(NSString *status,float delay);
extern void DYStatusBarShowWithDelayDisappearAndStyle(NSString *status,float delay,NSString *style);