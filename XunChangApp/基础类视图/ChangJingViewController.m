//
//  ChangJingViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/10.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "ChangJingViewController.h"
#import "ShenBaoLeiXingCell.h"
#import "UserCenterModel.h"
#import "UIImageView+WebCache.h"
@interface ChangJingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChangJingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"场景选择";
    [self createNavBackButt];
    self.tableView.tableFooterView=[UIView new];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShenBaoLeiXingCell *changJingCell=[tableView dequeueReusableCellWithIdentifier:@"ChangJingTableCell"];
    ScenesModel *sceneModel=[self.dataArray objectAtIndex:indexPath.row];
    [changJingCell.changJingImageView sd_setImageWithURL:[NSURL URLWithString:sceneModel.icon] placeholderImage:[UIImage imageNamed:@"icon_cqlogo"] options:SDWebImageProgressiveDownload];
    changJingCell.changJIngNameLabel.text=sceneModel.title;
    return changJingCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.sceneBlock([self.dataArray objectAtIndex:indexPath.row]);
    [self backToFrontViewController];
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
