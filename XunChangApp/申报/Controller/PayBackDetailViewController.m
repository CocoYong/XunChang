//
//  PayBackDetailViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/12.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "PayBackDetailViewController.h"

@interface PayBackDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PayBackDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"退款详情";
    [self createNavBackButt:@"黑色"];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return [tableView dequeueReusableCellWithIdentifier:@"PayBackDetailCellOne"];
        }
            break;
        case 1:
        {
            return [tableView dequeueReusableCellWithIdentifier:@"PayBackDetailCellTwo"];
        }
            break;
        case 2:
        {
            return [tableView dequeueReusableCellWithIdentifier:@"PayBackDetailCellThree"];
        }
            break;
        case 3:
        {
            return  [tableView dequeueReusableCellWithIdentifier:@"PayBackDetailCellFour"];
        }
            break;
        case 4:
        {
            return [tableView dequeueReusableCellWithIdentifier:@"PayBackDetailCellFive"];
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
            return 50;
            break;
        case 1:
            return 181;
            break;
        case 2:
            return 140;
            break;
        case 3:
            return 110;
            break;
        case 4:
            return 130;
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
