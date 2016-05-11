//
//  CustomerCell.m
//  TestProject
//
//  Created by MrZhang on 16/1/3.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "CustomerCell.h"

@implementation CustomerCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
        _backImageView=[[UIImageView alloc]init];
        _backImageView.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _backImageView.userInteractionEnabled=YES;
        [self.contentView addSubview:_backImageView];
        
        _bigTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height*2/3)];
        _bigTitleLabel.textAlignment=NSTextAlignmentCenter;
        _bigTitleLabel.font=[UIFont systemFontOfSize:14];
        _bigTitleLabel.textColor=[UIColor blackColor];
        _bigTitleLabel.text=@"bigTitle";
        [self.contentView addSubview:_bigTitleLabel];
        
        
        _smallTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height*2/3, self.bounds.size.width, self.bounds.size.height/3)];
        _smallTitleLabel.textAlignment=NSTextAlignmentCenter;
        _smallTitleLabel.textColor=[UIColor lightGrayColor];
        _smallTitleLabel.font=[UIFont systemFontOfSize:10];
        _smallTitleLabel.text=@"smallTitle";
        [self.contentView addSubview:_smallTitleLabel];
    }
    return self;
}
@end
