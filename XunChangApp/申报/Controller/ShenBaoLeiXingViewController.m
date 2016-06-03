//
//  ShenBaoLeiXingViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/10.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "ShenBaoLeiXingViewController.h"
#import "ShenBaoWorkObjectModel.h"
#import "ShenBaoLeiXingCell.h"
#import "UIImageView+WebCache.h"
#import "ShenBaoSelectItemListViewController.h"
@interface ShenBaoLeiXingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ShenBaoWorkObjectModel *objectModel;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShenBaoLeiXingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.itemDataModel.title;
    [self createNavBackButt];
    self.tableView.tableFooterView=[UIView new];
    self.tableView.sectionIndexBackgroundColor=[UIColor colorWithHexString:@"#f0f0f0"];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:GETOBJECT params:nil httpMethod:@"POST" block:^(id result) {
         [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        objectModel=[ShenBaoWorkObjectModel yy_modelWithDictionary:result];
        objectModel.datas=[NSArray yy_modelArrayWithClass:[ShenBaoWorkObjectDataModel class] json:[result objectForKey:@"data"]];
        [objectModel.datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ShenBaoWorkObjectDataModel   *secondModel=(ShenBaoWorkObjectDataModel*)obj;
            secondModel.objects=[NSArray yy_modelArrayWithClass:[ShenBaoWorkObjectDataObjectsModel class] json:[[[result objectForKey:@"data"] objectAtIndex:idx] objectForKey:@"objects"]];
        }];
        ShenBaoWorkObjectDataModel* thirdModel=(ShenBaoWorkObjectDataModel*)[objectModel.datas objectAtIndex:0];
        NSLog(@"thirdModel==model.datas===%@",thirdModel.objects);
        if (objectModel.code==0) {
            [self.tableView reloadData];
        }else if (objectModel.code==9999)
        {
            [SVProgressHUD  showErrorWithStatus:objectModel.message maskType:SVProgressHUDMaskTypeBlack];
        }else if(objectModel.code==1001)
        {
            [USER_DEFAULT removeObjectForKey:@"user_token"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }

      
    } errorBlock:^(NSError *error) {
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
        [SVProgressHUD  showErrorWithStatus:@"网络请求错误了..." maskType:SVProgressHUDMaskTypeBlack];
    } noNetWorking:^(NSString *noNetWorking) {
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
        [SVProgressHUD  showErrorWithStatus:@"没网了..." maskType:SVProgressHUDMaskTypeBlack];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return objectModel.datas.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ShenBaoWorkObjectDataModel *firstModel=[objectModel.datas objectAtIndex:section];
    return firstModel.objects.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShenBaoLeiXingCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ShenBaoLeiXingCell"];
    ShenBaoWorkObjectDataModel *tempModel=[objectModel.datas objectAtIndex:indexPath.section];
    ShenBaoWorkObjectDataObjectsModel *secondModel=[tempModel.objects objectAtIndex:indexPath.row];
    [cell.logoImageView sd_setImageWithURL:[NSURL URLWithString:secondModel.owner_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
     cell.nameLabel.text=secondModel.name;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headerView.backgroundColor=[UIColor colorWithHexString:@"#709B5A"];
    UILabel *headerLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH-40, 30)];
    headerLabel.textColor=[UIColor whiteColor];
    ShenBaoWorkObjectDataModel *tempModel=[objectModel.datas objectAtIndex:section];
    headerLabel.text=tempModel.area_name;
    [headerView addSubview:headerLabel];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShenBaoWorkObjectDataModel *tempModel=[objectModel.datas objectAtIndex:indexPath.section];
    ShenBaoWorkObjectDataObjectsModel *secondModel=[tempModel.objects objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShenBaoSelectItemListViewController" sender:secondModel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue destinationViewController] isKindOfClass:NSClassFromString(@"ShenBaoSelectItemListViewController")]) {
        ShenBaoWorkObjectDataObjectsModel *secondModel=(ShenBaoWorkObjectDataObjectsModel*)sender;
        ShenBaoSelectItemListViewController *itemViewController=[segue destinationViewController];
        itemViewController.itemObjectModel=self.itemDataModel;
        itemViewController.objectModel=secondModel;
    }
}


@end
