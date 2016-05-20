//
//  ShenBaoSelectItemListViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/10.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "ShenBaoSelectItemListViewController.h"
#import "ShenBaoSelectItemListCell.h"
#import "ShenBaoOrdersCommitViewController.h"
#import "ShenBaoKemuModel.h"
@interface ShenBaoSelectItemListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ShenBaoKemuModel *kemuModel;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShenBaoSelectItemListViewController

- (void)viewDidLoad {
    self.title=@"选择用电项目";
    [super viewDidLoad];
    [self createNavBackButt];
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"12",@"type_id", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:@"api/xcapply_mock/getItem" params:paramsDic httpMethod:@"POST" block:^(id result) {
         [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        kemuModel=[ShenBaoKemuModel yy_modelWithDictionary:result];
        kemuModel.datas=[NSArray yy_modelArrayWithClass:[ShenBaoKemuDataModel class] json:[result objectForKey:@"data"]];
        if (kemuModel.code==0) {
            [self.tableView reloadData];
        }else if (kemuModel.code==9999)
        {
           [SVProgressHUD  showErrorWithStatus:userModel.message maskType:SVProgressHUDMaskTypeBlack];
        }else if(kemuModel.code==1001)
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
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kemuModel.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShenBaoSelectItemListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ShenBaoSelectItemListCell"];
    ShenBaoKemuDataModel *tempModel=[kemuModel.datas objectAtIndex:indexPath.row];
    cell.nameLabel.text=[NSString stringWithFormat:@"%@ %@ %@",tempModel.title,tempModel.intro,tempModel.deposit];
    if (tempModel.select) {
        [cell.selectButt setImage:[UIImage imageNamed:@"icon_gx"] forState:UIControlStateNormal];
    }else
    {
       [cell.selectButt setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for (int i=0; i<kemuModel.datas.count; i++) {
    ShenBaoKemuDataModel *tempModel=[kemuModel.datas objectAtIndex:i];
        if (i==indexPath.row) {
            tempModel.select=YES;
        }else
        {
            tempModel.select=NO;
        }
    }
    [self.tableView reloadData];
    [self performSegueWithIdentifier:@"ShenBaoOrdersCommitViewController" sender:[kemuModel.datas objectAtIndex:indexPath.row]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ShenBaoOrdersCommitViewController *viewController=[segue destinationViewController];
    viewController.dataModel=sender;
}


@end
