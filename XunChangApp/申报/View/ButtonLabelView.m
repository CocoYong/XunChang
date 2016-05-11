//
//  ButtonLabelView.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/9.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "ButtonLabelView.h"
#import "CollectionBaseModel.h"
#define BUTTWIDTH 50
typedef void(^FiveButtCallBack)(id butt,id model);
@interface ButtonLabelView()
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,copy)FiveButtCallBack callBlock;
@end
@implementation ButtonLabelView
-(instancetype)initWithFrame:(CGRect)frame andModelArray:(NSArray*)modelsArray andCallBackBlock:(void(^)(id butt,id model))callBackBlock
{
    self=[super initWithFrame:frame];
    if(!self) return nil;
    CGFloat padding=(SCREEN_WIDTH-(modelsArray.count*BUTTWIDTH))/(modelsArray.count+1);
    self.callBlock=callBackBlock;
    for (int i=0; i<modelsArray.count; i++) {
      ITTAssert([[modelsArray objectAtIndex:i] isKindOfClass:[CollectionBaseModel class]],@"数据模型不对");
        CollectionBaseModel *model=(CollectionBaseModel*)modelsArray[i];
        UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(padding+(padding+50)*i, 10, BUTTWIDTH, BUTTWIDTH);
        butt.tag=i;
        [butt addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
        [butt setImage:[UIImage imageNamed:model.imageName] forState:UIControlStateNormal];
        [self addSubview:butt];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(padding+(padding+50)*i, 40, BUTTWIDTH, BUTTWIDTH)];
        label.text=model.titleName;
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:14];
        [self addSubview:label];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
              andTitlesArray:(NSArray *)titlesArray andDefaultSelectIndex:(NSInteger)index
            andCallBackBlock:(void (^)(id, id))callBackBlock
{
    self=[super initWithFrame:frame];
    if(!self) return nil;
    CGFloat padding=(SCREEN_WIDTH-(titlesArray.count*BUTTWIDTH))/(titlesArray.count+1);
    self.callBlock=callBackBlock;
    for (int i=0; i<titlesArray.count; i++) {
        ITTAssert([[titlesArray objectAtIndex:i] isKindOfClass:[NSString class]],@"传人数据不对");
        UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
        butt.frame=CGRectMake(padding+(padding+50)*i, 10, BUTTWIDTH, 21);
        butt.tag=i;
        [butt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        butt.titleLabel.font=[UIFont systemFontOfSize:14];
        [butt addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
        [butt setTitle:titlesArray[i] forState:UIControlStateNormal];
        [self addSubview:butt];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/titlesArray.count)*i, 38, SCREEN_WIDTH/titlesArray.count, 2)];
        lineView.hidden=YES;
        lineView.tag=butt.tag+5;
        lineView.backgroundColor=[UIColor greenColor];
        [self addSubview:lineView];
        if (index==i) {
            [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            lineView.hidden=NO;
        }
    }
    return self;
}
-(void)buttonTaped:(UIButton*)butt
{
    for (UIView *view in self.subviews) {
        if (view.tag!=butt.tag+5&&[view isMemberOfClass:[UIView class]]) {
            view.hidden=YES;
        }
        if (view.tag!=butt.tag&&[view isMemberOfClass:[UIButton class]]) {
            [(UIButton*)view  setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
    UIView *tempView=[self viewWithTag:butt.tag+5];
    tempView.hidden=NO;
    [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.callBlock(butt,[self.dataArray objectAtIndex:butt.tag]);
}
@end
