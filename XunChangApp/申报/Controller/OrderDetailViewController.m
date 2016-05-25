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
#import "MWPhotoBrowser.h"
#import "MWPhoto.h"
#import "GrayAlertView.h"
#import "LoginModel.h"
#import "PayViewController.h"
#import "EvaluateViewController.h"
#import "UpLoadServiceEvidenceViewController.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,MWPhotoBrowserDelegate>
{
    OrderDetailModel *detailModel;
    NSMutableArray *photosArray;
    NSMutableArray *payModelDataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"订单详情";
    [self createNavBackButt];
    //初始化支付页面用到数组
    payModelDataArray=[NSMutableArray arrayWithCapacity:12];
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.orderNum,@"order_num", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:@"api/xcapply_mock/orderDetail" params:paramsDic httpMethod:@"POST" block:^(id result) {
         [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        detailModel=[OrderDetailModel yy_modelWithDictionary:result];
        detailModel.data.progressArray=[NSArray yy_modelArrayWithClass:[OrderDetailDataProgressModel class] json:[[result objectForKey:@"data"] objectForKey:@"progress"]];
        detailModel.data.serviceFileArray=[NSArray yy_modelArrayWithClass:[OrderDetailDataServiceFileModel class] json:[[result objectForKey:@"data"] objectForKey:@"service_file"]];
        [detailModel.data.serviceFileArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            OrderDetailDataServiceFileModel *tempModel=(OrderDetailDataServiceFileModel *)obj;
            tempModel.imageUrlArray=[tempModel.url componentsSeparatedByString:@","];
        }];
        
        if (detailModel.code==0) {
            [payModelDataArray addObject:detailModel];
            [self.tableView reloadData];
        }else if (detailModel.code==9999)
        {
            [SVProgressHUD  showErrorWithStatus:detailModel.message maskType:SVProgressHUDMaskTypeBlack];
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
    if (section==7) {
        return detailModel.data.progressArray.count;
    }else{
        if (section==5) {
            return detailModel.data.serviceFileArray.count+1;
        }else
        {
          return 1;
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        OrderDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellOne"];
        [cell.changGuanIconImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.data.type_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
        [cell.objectIconImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.data.object_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
        if ([self.userType isEqualToString:@"apply_guest"]) {
            if ([detailModel.data.status isEqualToString:@"pending"]) {
                cell.orderStatusLabel.text=@"待付款";
                cell.orderStatusLabel.textColor=[UIColor colorWithHexString:@"#D16A38"];
            }else if ([detailModel.data.status isEqualToString:@"starting"])
            {
                cell.orderStatusLabel.text=@"付款成功";
                cell.orderStatusLabel.textColor=[UIColor colorWithHexString:@"#8DAE7F"];
            }
            else if ([detailModel.data.status isEqualToString:@"finish"])
            {
                cell.orderStatusLabel.text=@"等待确定";
                cell.orderStatusLabel.textColor=[UIColor colorWithHexString:@"#8DAE7F"];
            }else{
                cell.orderStatusLabel.text=@"交易成功";
                cell.orderStatusLabel.textColor=[UIColor colorWithHexString:@"#8DAE7F"];
            }
        }else
        {
            if ([detailModel.data.task_status isEqualToString:@"starting"]) {
                cell.orderStatusLabel.text=@"付款成功";
                cell.orderStatusLabel.textColor=[UIColor colorWithHexString:@"#8DAE7F"];
            }else if([detailModel.data.task_status isEqualToString:@"finish"])
            {
                cell.orderStatusLabel.text=@"完成服务";
                cell.orderStatusLabel.textColor=[UIColor colorWithHexString:@"#8DAE7F"];
            }else
            {
                cell.orderStatusLabel.text=@"交易成功";
                cell.orderStatusLabel.textColor=[UIColor colorWithHexString:@"#8DAE7F"];
            }
        }
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
      OrderDetailCell *cellTwo=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellThree"];
        [cellTwo.photoImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.data.avatar] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
         cellTwo.userTypeLabel.text=@"申请人";
        cellTwo.clearButt.tag=111;
        [cellTwo.clearButt addTarget:self action:@selector(telephoneButtAction:) forControlEvents:UIControlEventTouchUpInside];
        cellTwo.nameLabel.text=detailModel.data.realname;
        if (![detailModel.data.show_guest isEqualToString:@"Y"]) {
            cellTwo.hidden=YES;
        }else
        {
            cellTwo.hidden=NO;
        }
        return cellTwo;
    }
    else if(indexPath.section==3){
        OrderDetailCell *cellThree=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellThree"];
        [cellThree.photoImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.data.staff_avatar] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
        cellThree.clearButt.tag=222;
        [cellThree.clearButt addTarget:self action:@selector(telephoneButtAction:) forControlEvents:UIControlEventTouchUpInside];
        cellThree.nameLabel.text=detailModel.data.staff_realname;
        cellThree.userTypeLabel.text=@"服务执行人";
        if (![detailModel.data.show_staff isEqualToString:@"Y"]) {
            cellThree.hidden=YES;
        }else
        {
            cellThree.hidden=NO;
        }
        return cellThree;
    }
    else if(indexPath.section==4){
        OrderDetailCell *cellFour=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellThree"];
        [cellFour.photoImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.data.checker_avatar] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
        cellFour.clearButt.tag=333;
        [cellFour.clearButt addTarget:self action:@selector(telephoneButtAction:) forControlEvents:UIControlEventTouchUpInside];
        cellFour.nameLabel.text=detailModel.data.checker_realname;
        cellFour.userTypeLabel.text=@"服务检查人";
        if (![detailModel.data.show_service isEqualToString:@"Y"]) {
            cellFour.hidden=YES;
        }else
        {
            cellFour.hidden=NO;
        }
        return cellFour;
    }
    else if(indexPath.section==5){
        if (indexPath.row==0) {
            OrderDetailCell *cellFive=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellFour"];
            cellFive.completEvidenceTimeLabel.text=detailModel.data.paid_time;
            cellFive.serviceDetailLabel.text=detailModel.data.service_message;
            return cellFive;
        }else
        {
           OrderDetailCell *cellFiveImage=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellSeven"];
            OrderDetailDataServiceFileModel *tempModel=[detailModel.data.serviceFileArray objectAtIndex:indexPath.row-1];
             [cellFiveImage.detailImageView sd_setImageWithURL:[NSURL URLWithString:[tempModel.imageUrlArray objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
              cellFiveImage.imageNameLabel.text=tempModel.filename;
            cellFiveImage.imageSizeLabel.text=[self bytesToMBOrKB:tempModel.size];
            cellFiveImage.imageCreatTimeLabel.text=tempModel.create_time;
            return cellFiveImage;
        }
    }
    else if(indexPath.section==6){
        OrderDetailCell *cellSix=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellFive"];
//        cellFive.starBackView.hidden=
        cellSix.starView.value=detailModel.data.start;
        cellSix.starView.enabled=NO;
        cellSix.scoreLabel.text=[NSString stringWithFormat:@"%d",detailModel.data.start];
        cellSix.placeHoldViewFive.text=detailModel.data.comment;
        cellSix.placeHoldViewFive.editable=NO;
        if (![detailModel.data.show_comment isEqualToString:@"Y"]) {
            cellSix.hidden=YES;
        }else
        {
            cellSix.hidden=NO;
        }
        return cellSix;
    }
    else if(indexPath.section==7){
        OrderDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellSix"];
        OrderDetailDataProgressModel *progressModel=[detailModel.data.progressArray objectAtIndex:indexPath.row];
        cell.orderActionLabel.text=progressModel.title;
        cell.orderActionTimeLabel.text=progressModel.create_time;
        cell.orderActionInfoLabel.text=progressModel.message;
        if (indexPath.row==detailModel.data.progressArray.count-1) {
            cell.radioImageView.image=[UIImage imageNamed:@"icon_ld"];
        }else
        {
           cell.radioImageView.image=[UIImage imageNamed:@"icon_hd"]; 
        }
        return cell;
    }else
    {
        OrderDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailCellEight"];
        [cell.buttonThree addTarget:self action:@selector(payButtAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.buttOne addTarget:self action:@selector(deletButtAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.buttonTwo addTarget:self action:@selector(cancelButtAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.buttOne.tag=indexPath.row*3;
        cell.buttonTwo.tag=indexPath.row*3+1;
        cell.buttonThree.tag=indexPath.row*3+2;
        if ([self.userType isEqualToString:@"apply_guest"]) {  //申报人
            if ([detailModel.data.status isEqualToString:@"pending"]) {
                cell.buttOne.hidden=YES;
                [cell.buttonTwo setTitle:@"取消订单" forState:UIControlStateNormal];
                [cell.buttonTwo setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [cell.buttonTwo setBackgroundColor:[UIColor whiteColor]];
                [cell.buttonThree setBackgroundColor:[UIColor colorWithHexString:@"#D16A38"]];
                [cell.buttonThree setTitle:@"付款" forState:UIControlStateNormal];
                [cell.buttonThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else if ([detailModel.data.status isEqualToString:@"starting"])
            {
                cell.buttOne.hidden=YES;
                [cell.buttonThree setTitle:@"投诉" forState:UIControlStateNormal];
                [cell.buttonThree setBackgroundColor:[UIColor colorWithHexString:@"#D16A38"]];
                [cell.buttonThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [cell.buttonTwo setTitle:@"联系服务" forState:UIControlStateNormal];
                [cell.buttonTwo setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [cell.buttonTwo setBackgroundColor:[UIColor whiteColor]];
            }
            else if ([detailModel.data.status isEqualToString:@"finish"])
            {
                cell.buttOne.hidden=YES;
                [cell.buttonThree setTitle:@"签收" forState:UIControlStateNormal];
                [cell.buttonThree setBackgroundColor:[UIColor colorWithHexString:@"#D16A38"]];
                [cell.buttonThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [cell.buttonTwo setTitle:@"投诉" forState:UIControlStateNormal];
                [cell.buttonTwo setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [cell.buttonTwo setBackgroundColor:[UIColor whiteColor]];
            }else{
                if ([detailModel.data.show_comment isEqualToString:@"Y"]) {
                    [cell.buttonThree setBackgroundColor:[UIColor whiteColor]];
                    [cell.buttonThree setTitle:@"投诉" forState:UIControlStateNormal];
                    [cell.buttonThree setTitleColor:[UIColor colorWithHexString:@"#A5A6A7"] forState:UIControlStateNormal];
                    cell.buttonThree.layer.borderColor=[UIColor colorWithHexString:@"#DCDDDD"].CGColor;
                    cell.buttonThree.layer.borderWidth=1.0f;
                    [cell.buttonTwo setTitle:@"删除订单" forState:UIControlStateNormal];
                    [cell.buttonTwo setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                    [cell.buttonTwo setBackgroundColor:[UIColor whiteColor]];
                    
                }else
                {
                    [cell.buttonThree setBackgroundColor:[UIColor colorWithHexString:@"#8AAC7B"]];
                    [cell.buttonThree setTitle:@"评价" forState:UIControlStateNormal];
                    [cell.buttonTwo setTitle:@"投诉" forState:UIControlStateNormal];
                    [cell.buttonTwo setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                    [cell.buttonTwo setBackgroundColor:[UIColor whiteColor]];
                    cell.buttOne.hidden=NO;
                }
            }
        }else     //服务人
        {
            cell.buttOne.hidden=YES;
            cell.buttonTwo.hidden=YES;
            if ([detailModel.data.task_status isEqualToString:@"starting"]) {
                [cell.buttonThree setTitle:@"完成服务" forState:UIControlStateNormal];
                cell.buttonThree.backgroundColor=[UIColor colorWithHexString:@"#CE6836"];
                [cell.buttonThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
           else if ([detailModel.data.task_status isEqualToString:@"finish"]) {
               [cell.buttonThree setTitle:@"等待签收" forState:UIControlStateNormal];
               cell.buttonThree.backgroundColor=[UIColor whiteColor];
               [cell.buttonThree setTitleColor:[UIColor colorWithHexString:@"#CE6836"] forState:UIControlStateNormal];
            }else
            {
                cell.hidden=YES;
            }
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
        return 89;
    }else if (indexPath.section==5)
    {
        if (indexPath.row==0) {
            return 120;
        }else
        {
            return 60;
        }
    }else if (indexPath.section==6)
    {
        if (![detailModel.data.show_comment isEqualToString:@"Y"]) {
            return 0;
        }
        return 224;
    }else if (indexPath.section==7)
    {
        return 73;
    }else
    {
        if ([self.userType isEqualToString:@"apply_staff"]&&[detailModel.data.task_status isEqualToString:@"sign"]) {
            return 0;
        }else
        {
           return 50;
        }
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else{
        if (section==2&&![detailModel.data.show_guest isEqualToString:@"Y"]) {
            return 0;
        }else if (section==3&&![detailModel.data.show_staff isEqualToString:@"Y"])
        {
            return 0;
        }else if (section==4&&![detailModel.data.show_service isEqualToString:@"Y"])
        {
            return 0;
        }else if (section==6&&![detailModel.data.show_comment isEqualToString:@"Y"])
        {
            return 0;
        }else if(section==8&&[detailModel.data.task_status isEqualToString:@"signin"])
        {
            return 0;
        }else
        {
           return 10;
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==5&&indexPath.row>0) {
        OrderDetailDataServiceFileModel *tempModel=[detailModel.data.serviceFileArray objectAtIndex:indexPath.row-1];
        [self browerPhoto:tempModel.imageUrlArray];
    }
}
-(void)telephoneButtAction:(UIButton*)sender
{
    if (sender.tag==111) {
        [self dialTelephoneWithTelephoneNum:detailModel.data.tel];
    }else if(sender.tag==222)
    {
      [self dialTelephoneWithTelephoneNum:detailModel.data.staff_tel];
    }else
    {
       [self dialTelephoneWithTelephoneNum:detailModel.data.checker_tel];
    }
}

#pragma mark---------cellButtAction-----------
- (void)payButtAction:(UIButton*)sender {
    if ([sender.titleLabel.text isEqualToString:@"付款"]) {
        UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PayViewController *payController=[mainStoryboard instantiateViewControllerWithIdentifier:@"PayViewController"];
        payController.dataArray=[payModelDataArray copy];
        [self showViewController:payController sender:self];
    }else if ([sender.titleLabel.text isEqualToString:@"签收"])
    {
        [GrayAlertView showAlertViewWithFirstButtTitle:@"我要投诉" secondButtTitle:@"现在评价" andAlertText:@"您已签收,确认申报服务完成." remindTitleColor:[UIColor colorWithHexString:@"#999999"] buttOneTitleColor:[UIColor whiteColor] buttTwoTitleColor:[UIColor whiteColor] buttOneBackGroundColor:[UIColor colorWithHexString:@"#6AAB20"] buttTwoBackColor:[UIColor colorWithHexString:@"#6AAB20"] andCallBackBlock:^(UIButton *butt) {
            if (butt.tag==1) {
                [self dialTelephoneWithTelephoneNum:detailModel.data.checker_tel];
            }else
            {
                [self recieveGoodsRequest:detailModel.data.order_num];
            }
        }];
    }else if([sender.titleLabel.text isEqualToString:@"投诉"])
    {
        [self dialTelephoneWithTelephoneNum:detailModel.data.checker_tel];
    }else if ([sender.titleLabel.text isEqualToString:@"评价"])
    {
        UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        EvaluateViewController *evaluateController=[mainStoryboard instantiateViewControllerWithIdentifier:@"EvaluateViewController"];
        evaluateController.orderNum=detailModel.data.order_num;
        [self showViewController:evaluateController sender:self];
    }else if ([sender.titleLabel.text isEqualToString:@"完成服务"]) {
        UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UpLoadServiceEvidenceViewController *uploadEvidenceController=[mainStoryboard instantiateViewControllerWithIdentifier:@"UpLoadServiceEvidenceViewController"];
        uploadEvidenceController.orderNum=detailModel.data.order_num;
        [self showViewController:uploadEvidenceController sender:self];
    }
}
- (void)cancelButtAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"联系服务"]) {
        [self dialTelephoneWithTelephoneNum:detailModel.data.staff_tel];
    }else if ([sender.titleLabel.text isEqualToString:@"取消订单"])
    {
        [GrayAlertView showAlertViewWithFirstButtTitle:@"确认取消" secondButtTitle:@"再看一看" andAlertText:@"是否取消订单?" remindTitleColor:[UIColor colorWithHexString:@"#999999"] buttOneTitleColor:[UIColor whiteColor] buttTwoTitleColor:[UIColor whiteColor] buttOneBackGroundColor:[UIColor colorWithHexString:@"#6AAB20"] buttTwoBackColor:[UIColor colorWithHexString:@"#E4E4E4"] andCallBackBlock:^(UIButton *butt) {
            if (butt.tag==1) {
                [self cancelOrderRequest:detailModel.data.order_num];
            }
        }];
    }else if([sender.titleLabel.text isEqualToString:@"投诉"])
    {
        [self dialTelephoneWithTelephoneNum:detailModel.data.checker_tel];
    }else if ([sender.titleLabel.text isEqualToString:@"删除订单"])
    {
        [self deletOrderWithOrderNum:detailModel.data.order_num];
    }
}
-(void)deletButtAction:(UIButton*)sender
{
    [self deletOrderWithOrderNum:detailModel.data.order_num];
}
#pragma mark-------------订单操作-----取消  删除   签收----------
//取消订单
-(void)cancelOrderRequest:(NSString*)orderNum
{
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:orderNum,@"order_num", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:@"api/xcapply_mock/ordercancel" params:paramsDic httpMethod:@"POST" block:^(id result) {
        [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        LoginModel *tempModel=[LoginModel yy_modelWithDictionary:result];
        if (tempModel.code==0) {
            [self backToFrontViewController];
        }else if (tempModel.code==9999)
        {
            [SVProgressHUD  showErrorWithStatus:tempModel.message maskType:SVProgressHUDMaskTypeBlack];
        }else if(tempModel.code==1001)
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
//删除订单
-(void)deletOrderWithOrderNum:(NSString*)orderNum
{
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:orderNum,@"order_num", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:@"api/xcapply_mock/orderDelete" params:paramsDic httpMethod:@"POST" block:^(id result) {
        [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        LoginModel *tempModel=[LoginModel yy_modelWithDictionary:result];
        if (tempModel.code==0) {
            [self backToFrontViewController];  //重新请求数据刷新列表
        }else if (tempModel.code==9999)
        {
            [SVProgressHUD  showErrorWithStatus:tempModel.message maskType:SVProgressHUDMaskTypeBlack];
        }else if(tempModel.code==1001)
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
//签收订单.....
-(void)recieveGoodsRequest:(NSString*)orderNum
{
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:orderNum,@"order_num", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:@"api/xcapply_mock/orderSign" params:paramsDic httpMethod:@"POST" block:^(id result) {
        [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        LoginModel *tempModel=[LoginModel yy_modelWithDictionary:result];
        if (tempModel.code==0) {
            UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            EvaluateViewController *evaluateController=[mainStoryboard instantiateViewControllerWithIdentifier:@"EvaluateViewController"];
            evaluateController.orderNum=orderNum;
            [self showViewController:evaluateController sender:self];
        }else if (tempModel.code==9999)
        {
            [SVProgressHUD  showErrorWithStatus:tempModel.message maskType:SVProgressHUDMaskTypeBlack];
        }else if(tempModel.code==1001)
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

#pragma mark------------查看照片逻辑---------------------
-(void)browerPhoto:(NSArray*)photoArray
{
    photosArray=[NSMutableArray array];
    [photoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MWPhoto *photo=[MWPhoto photoWithURL:[NSURL URLWithString:obj]];
        [photosArray addObject:photo];
    }];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;//分享按钮,默认是
    browser.displayNavArrows = YES;//左右分页切换,默认否
    browser.displaySelectionButtons = NO;//是否显示选择按钮在图片上,默认否
    browser.alwaysShowControls = YES;//控制条件控件 是否显示,默认否
    browser.zoomPhotosToFill = NO;//是否全屏,默认是
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    browser.wantsFullScreenLayout = NO;//是否全屏
#endif
    browser.enableGrid = NO;//是否允许用网格查看所有图片,默认是
    browser.startOnGrid = NO;//是否第一张,默认否
    browser.enableSwipeToDismiss = YES;
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    [browser setCurrentPhotoIndex:0];
    //    [self presentViewController:browser animated:YES completion:nil];
    [self.navigationController pushViewController:browser animated:NO];
}
#pragma mark - MWPhotoBrowserDelegate
-(id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index<photosArray.count) {
        return [photosArray objectAtIndex:index];
    }
    return nil;
}
-(NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return photosArray.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:NSClassFromString(@"PayViewController")]) {
        PayViewController *payController=[segue destinationViewController];
        payController.dataArray=[payModelDataArray copy];
    }else if ([[segue destinationViewController] isKindOfClass:NSClassFromString(@"EvaluateViewController")]){
        EvaluateViewController *evaluateController=[segue destinationViewController];
        evaluateController.orderNum=sender;
    }
}


@end
