//
//  OrderDetailViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/12.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailCell.h"
#import "OrderDetailModel.h"
#import "UIImageView+WebCache.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    OrderDetailModel *detailModel;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"订单详情";
    [self createNavBackButt];
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@123,@"order_num", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:@"api/xcapply_mock/orderDetail" params:paramsDic httpMethod:@"POST" block:^(id result) {
         [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        detailModel=[OrderDetailModel yy_modelWithDictionary:result];
        if (detailModel.code==0) {
            [self.tableView reloadData];
        }else if (detailModel.code==9999)
        {
            [SVProgressHUD showWithStatus:detailModel.message];
        }else if(detailModel.code==1001)
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
    if (section==6) {
        return 6;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        OrderDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellOne"];
        [cell.changGuanIconImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.data.type_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
        [cell.objectIconImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.data.object_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
        cell.orderStatusLabel.text=detailModel.data.status;
        cell.changGuanLabel.text=detailModel.data.object_address;
        cell.objectCountLabel.text=[NSString stringWithFormat:@"x%@",detailModel.data.num];
        cell.orderNumLabel.text=detailModel.data.order_num;
        cell.useMoneyLabel.text=detailModel.data.total_money;
        cell.dispositMoneyLabel.text=detailModel.data.total_deposit_money;
        cell.totalMoneyLabel.text=detailModel.data.total_use_money;
        return cell;
    }
    else if(indexPath.section==1){
        OrderDetailCell *cellTwo=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellTwo"];
        cellTwo.startTimeLabel.text=detailModel.data.start_time;
        cellTwo.endTimeLabel.text=detailModel.data.end_time;
        return cellTwo;
    }
    else if(indexPath.section==2){
      OrderDetailCell *cellThree=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellThree"];
        [cellThree.photoImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.data.type_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
         cellThree.userTypeLabel.text=@"申请人";
        cellThree.nameLabel.text=detailModel.data.realname;
        return cellThree;
    }
    else if(indexPath.section==3){
        OrderDetailCell *cellThree=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellThree"];
        [cellThree.photoImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.data.type_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
        cellThree.nameLabel.text=detailModel.data.staff_realname;
        cellThree.userTypeLabel.text=@"服务执行人";
        return cellThree;
    }
    else if(indexPath.section==4){
        OrderDetailCell *cellFour=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellFour"];
        cellFour.completEvidenceTimeLabel.text=detailModel.data.paid_time;
//        cellFour.placeHolderViewFour.text=
         [cellFour.bigImageViewFour sd_setImageWithURL:[NSURL URLWithString:detailModel.data.type_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
        return cellFour;
    }
    else if(indexPath.section==5){
        OrderDetailCell *cellFive=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellFive"];
//        cellFive.starBackView.hidden=
        cellFive.starView.value=detailModel.data.start;
        cellFive.scoreLabel.text=[NSString stringWithFormat:@"%d",detailModel.data.start];
        cellFive.placeHoldViewFive.text=detailModel.data.service_message;
        return cellFive;
    }
    else{
        OrderDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellSix"];
        if (indexPath.row==0) {
            cell.orderActionLabel.text=@"提交订单";
            cell.orderActionTimeLabel.text=detailModel.data.create_time;
        }else if (indexPath.row==1)
        {
            cell.orderActionLabel.text=@"取消订单";
           cell.orderActionTimeLabel.text=detailModel.data.cancel_time;
        }else if (indexPath.row==2)
        {
            cell.orderActionLabel.text=@"完成支付";
          cell.orderActionTimeLabel.text=detailModel.data.paid_time;
        }
        else if (indexPath.row==3)
        {
            cell.orderActionLabel.text=@"服务执行确认";
         cell.orderActionTimeLabel.text=detailModel.data.finish_time;
        }
        else if (indexPath.row==4)
        {
            cell.orderActionLabel.text=@"订单签收确认";
         cell.orderActionTimeLabel.text=detailModel.data.sign_time;
        }else
        {
          cell.orderActionLabel.text=@"交易成功";
          cell.orderActionTimeLabel.text=detailModel.data.end_time;
        }
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 202;
    }else if (indexPath.section==1)
    {
        return 67;
    }else if (indexPath.section==2)
    {
        return 89;
    }else if (indexPath.section==3)
    {
        return 89;
    }else if (indexPath.section==4)
    {
        return 308;
    }else if (indexPath.section==5)
    {
        return 224;
    }else
    {
        return 73;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if ([self.userType isEqualToString:@"shenBaoRen"]) {
//        return 4;
//    }else{
     return 7;
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else
    return 10;
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
