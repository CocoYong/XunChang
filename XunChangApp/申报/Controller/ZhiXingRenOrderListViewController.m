//
//  ZhiXingRenOrderListViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/18.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "ZhiXingRenOrderListViewController.h"
#import "OrderListModel.h"
#import "ZhiXingRenOrderCell.h"
#import "UIImageView+WebCache.h"
#import "UpLoadServiceEvidenceViewController.h"
#import "OrderDetailViewController.h"
@interface ZhiXingRenOrderListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    OrderListModel *model;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSString *markOrderNum;//记录订单号
@end

@implementation ZhiXingRenOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申报";
    [self createNavBackButt];
    [self requestOrderListData];
}
-(void)requestOrderListData
{
//    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"status", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:@"api/xcapply_mock/staffOrderList" params:nil httpMethod:@"POST" block:^(id result) {
        [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        NSDictionary *resultDic=(NSDictionary*)result;
        model=[OrderListModel yy_modelWithDictionary:resultDic];
        model.datas=[NSArray yy_modelArrayWithClass:[OrderListDataModel class] json:[resultDic objectForKey:@"data"]];
        if (model.code==0) {
            [self.tableView reloadData];
        }else if (model.code==9999)
        {
            [SVProgressHUD  showErrorWithStatus:model.message maskType:SVProgressHUDMaskTypeBlack];
        }else if(model.code==1001)
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




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return model.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZhiXingRenOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ZhiXingRenOrderCell"];
    OrderListDataModel *secondModel=[model.datas objectAtIndex:indexPath.row];
    [cell.changGuanImageView sd_setImageWithURL:[NSURL URLWithString:secondModel.type_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
    [cell.objectImageView sd_setImageWithURL:[NSURL URLWithString:secondModel.object_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
    cell.changGuanNameLabel.text=secondModel.object_address;
    
    cell.objectDetailLabel.text=secondModel.item_title;
    cell.objectNumLabel.text=[NSString stringWithFormat:@"x%d",[secondModel.num integerValue]];
    cell.shenBaoRenLabel.text=[NSString stringWithFormat:@"申报人:%@(%@)",secondModel.guest_realname,secondModel.guest_tel];
    cell.startTimeLabel.text=[NSString stringWithFormat:@"开始使用时间:%@",secondModel.start_time];
    [cell.statusButt addTarget:self action:@selector(statusButtAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.statusButt.tag=indexPath.row*2+1;
    if ([secondModel.task_status isEqualToString:@"starting"]) {
         cell.statusLabel.text=@"付款成功";
        [cell.statusButt setTitle:@"完成服务" forState:UIControlStateNormal];
        cell.statusButt.backgroundColor=[UIColor colorWithHexString:@"#CE6836"];
        [cell.statusButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.telephoneButt.hidden=NO;
        cell.starBackView.hidden=YES;
        
    }else if ([secondModel.task_status isEqualToString:@"finish"])
    {
         cell.statusLabel.text=@"完成服务";
        [cell.statusButt setTitle:@"等待签收" forState:UIControlStateNormal];
        cell.statusButt.backgroundColor=[UIColor whiteColor];
        [cell.statusButt setTitleColor:[UIColor colorWithHexString:@"#CE6836"] forState:UIControlStateNormal];
        cell.telephoneButt.hidden=NO;
        cell.starBackView.hidden=YES;
    }else
    {
          cell.statusLabel.text=@"交易成功";
        if ([secondModel.is_comment isEqualToString:@"Y"]) {
            cell.starBackView.hidden=NO;
            cell.statusButt.hidden=YES;
            cell.telephoneButt.hidden=YES;
            cell.starView.value=[secondModel.star integerValue];
            cell.starView.enabled=NO;
            cell.scoreLabel.text=secondModel.star;
        }else
        {
            cell.starBackView.hidden=YES;
            cell.scoreLabel.hidden=YES;
            cell.statusButt.hidden=NO;
            cell.telephoneButt.hidden=YES;
            cell.statusButt.backgroundColor=[UIColor whiteColor];
            [cell.statusButt setTitleColor:[UIColor colorWithHexString:@"#CE6836"] forState:UIControlStateNormal];
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 214;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderListDataModel *tempModel=[model.datas objectAtIndex:indexPath.row];
    self.markOrderNum=tempModel.order_num;
    [self performSegueWithIdentifier:@"OrderDetailViewController" sender:self];
}
-(void)statusButtAction:(UIButton*)sender
{
    if ([sender.titleLabel.text isEqualToString:@"完成服务"]) {
        OrderListDataModel *tempModel=[model.datas objectAtIndex:sender.tag/2];
        self.markOrderNum=tempModel.order_num;
        [self performSegueWithIdentifier:@"UpLoadServiceEvidenceViewController" sender:self];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue destinationViewController] isKindOfClass:NSClassFromString(@"UpLoadServiceEvidenceViewController")]) {
        UpLoadServiceEvidenceViewController *viewComtroller=[segue destinationViewController];
        viewComtroller.orderNum=self.markOrderNum;
    }else if([[segue destinationViewController] isKindOfClass:NSClassFromString(@"OrderDetailViewController")])
    {
        OrderDetailViewController *viewComtroller=[segue destinationViewController];
        viewComtroller.userType=@"staff";
        viewComtroller.orderNum=self.markOrderNum;
    }
}


@end
