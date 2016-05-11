//
//  ButtonLabelView.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/9.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonLabelView : UIView
-(instancetype)initWithFrame:(CGRect)frame andModelArray:(NSArray*)modelsArray andCallBackBlock:(void(^)(id butt,id model))callBackBlock;
-(instancetype)initWithFrame:(CGRect)frame andTitlesArray:(NSArray*)titlesArray andDefaultSelectIndex:(NSInteger)index andCallBackBlock:(void(^)(id butt,id model))callBackBlock;
@end
