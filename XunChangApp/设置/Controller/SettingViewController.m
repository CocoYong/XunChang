//
//  SettingViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/9.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableCell.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *titleArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *logoutButt;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    [self createNavBackButt];
    titleArray=[NSMutableArray array];
//    [titleArray addObject:@[@"帐号与安全"]];
//    [titleArray addObject:@[@"消息设置",@"关于巡场",@"帮助与反馈"]];
//    [titleArray addObject:@[@"清除缓存"]];
    [titleArray addObject:@[@"关于巡场"]];
//    [titleArray addObject:@[@"消息设置",@"关于巡场",@"帮助与反馈"]];
    [titleArray addObject:@[@"修改资料"]];
    self.tableView.tableFooterView=[UIView new];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section==1) {
//        return 3;
//    }else
//    {
        return 1;
//    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SettingTableCellOne"];
    cell.mainTitleLael.text=[[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
