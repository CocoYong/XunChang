//
//  ShenBaoOrdersCommitViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/10.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "ShenBaoOrdersCommitViewController.h"

@interface ShenBaoOrdersCommitViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ShenBaoOrdersCommitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"提交申报订单";
    [self createNavBackButt:@"白色"];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return [tableView dequeueReusableCellWithIdentifier:@"ShenBaoOrdersHeaderCellOne"];
        }
            break;
        case 1:
        {
            return [tableView dequeueReusableCellWithIdentifier:@"ShenBaoOrdersHeaderCellTwo"];
        }
            break;
        case 2:
        {
            return [tableView dequeueReusableCellWithIdentifier:@"CellStyleOne"];
        }
            break;
        case 3:
        {
            return  [tableView dequeueReusableCellWithIdentifier:@"CellStyleTwo"];
        }
            break;
        case 4:
        {
            return [tableView dequeueReusableCellWithIdentifier:@"CellStyleThree"];
        }
            break;
        case 5:
        {
            return [tableView dequeueReusableCellWithIdentifier:@"CellStyleFour"];
        }
            break;
        case 6:
        {
         return [tableView dequeueReusableCellWithIdentifier:@"CellStyleFive"];
        }
            break;
            
        default:
            return [tableView dequeueReusableCellWithIdentifier:@"CellStyleFive"];
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 208;
            break;
        case 1:
            return 145;
            break;
        case 2:
            return 44;
            break;
        case 3:
            return 99;
            break;
        case 4:
            return 102;
            break;
        case 5:
            return 151;
            break;
        case 6:
            return 200;
            break;
        default:
            return 44;
            break;
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
