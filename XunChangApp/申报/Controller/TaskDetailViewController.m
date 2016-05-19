//
//  TaskDetailViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/12.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "TaskDetailViewController.h"
#import "TaskDetailCell.h"
@interface TaskDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"任务详情";
    [self createNavBackButt];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1)
    {
        return 3; //或者4
    }else
    {
        return 7;//或者更多
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        TaskDetailCell *cellOne=[tableView dequeueReusableCellWithIdentifier:@"TaskDetailCellOne"];
        return cellOne;
    }else if(indexPath.section==2&&indexPath.row>1)  //执行人列表
    {
        TaskDetailCell *cellTwo=[tableView dequeueReusableCellWithIdentifier:@"TaskDetailCellTwo"];
        return cellTwo;
    }else
    {
        TaskDetailCell *cellThree=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellOne"];
        return cellThree;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return 170;
    }else
    {
        return 44;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
