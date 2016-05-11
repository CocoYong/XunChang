//
//  BaseTableView.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/5.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "BaseTableView.h"
@interface BaseTableView()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataSourceArray;
}
@end
@implementation BaseTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self=[super initWithFrame:frame style:style];
    if (!self) return nil;
    self.delegate=self;
    self.dataSource=self;
    
    
    return self;
}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
