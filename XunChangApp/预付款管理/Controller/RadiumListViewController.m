//
//  RadiumListViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/23.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "RadiumListViewController.h"
#import "ShenBaoLeiXingCell.h"
#import "UIImageView+WebCache.h"
@interface RadiumListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RadiumListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"场馆选择";
    [self createNavBackButt];
    self.tableView.tableFooterView=[UIView new];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objectsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShenBaoLeiXingCell *changJingCell=[tableView dequeueReusableCellWithIdentifier:@"ChangJingTableCell"];
    YuFuKuanDataObjectsModel *objectModel=[self.objectsArray objectAtIndex:indexPath.row];
    [changJingCell.changJingImageView sd_setImageWithURL:[NSURL URLWithString:objectModel.icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
    changJingCell.changJIngNameLabel.text=objectModel.object_title;
    return changJingCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.objectCallBlock([self.objectsArray objectAtIndex:indexPath.row]);
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
