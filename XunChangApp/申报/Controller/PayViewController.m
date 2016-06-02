//
//  PayViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/11.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "PayViewController.h"
#import "OrderListModel.h"
#import "PayControllerCell.h"
#import "MoneyModel.h"
#import "PayResultViewController.h"
#import "LoginModel.h"
#import "ShenBaoKemuModel.h"
#import "OrderDetailModel.h"
@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MoneyModel *model;
    __block CGFloat totalMoney;
    BOOL canUsePrepayMoney;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *payButt;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"确认支付";
    [self createNavBackButt];
    
    //第一行显示的总钱数
        totalMoney=0;
        [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[OrderListDataModel class]]) {
                OrderListDataModel *orderModel=(OrderListDataModel*)obj;
                totalMoney +=[orderModel.total_money floatValue];
                self.object_id=orderModel.object_id;
            }else if ([obj isKindOfClass:[OrderDetailModel class]])
            {
                OrderDetailModel *orderDetailModel=(OrderDetailModel*)obj;
                totalMoney=[orderDetailModel.data.total_money floatValue];
                self.object_id=orderDetailModel.data.object_id;
            }
            else{
                ShenBaoKemuDataModel *keMuModel=(ShenBaoKemuDataModel*)obj;
                if (keMuModel.hasSquare) {
                 totalMoney=([keMuModel.price floatValue]*keMuModel.squareNum+[keMuModel.deposit_money floatValue])*[keMuModel.object_num integerValue];
                }else
                {
                    totalMoney=([keMuModel.price floatValue]+[keMuModel.deposit_money floatValue])*[keMuModel.object_num integerValue];
                }
            }
        }];
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.object_id,@"object_id", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:GETOBJECTMONEY params:paramsDic httpMethod:@"POST" block:^(id result) {
         [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        model=[MoneyModel yy_modelWithDictionary:result];
        if (model.code==0) {
            canUsePrepayMoney=YES;
            [self.tableView reloadData];
        }
        else if (model.code==8002)
        {
            canUsePrepayMoney=NO;
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
    } noNetWorking:^(NSString *noNetWorking){
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
        [SVProgressHUD  showErrorWithStatus:@"没网了..." maskType:SVProgressHUDMaskTypeBlack];
    }];
    self.payButt.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSMutableArray *orderNumArray=[NSMutableArray array];
        [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[OrderListDataModel class]]) {
                OrderListDataModel *orderModel=(OrderListDataModel*)obj;
                [orderNumArray addObject:orderModel.order_num];
            }else if ([obj isKindOfClass:[OrderDetailModel class]])
            {
                OrderDetailModel *orderDetailModel=(OrderDetailModel*)obj;
                [orderNumArray addObject:orderDetailModel.data.order_num];
            }
            else{
                ShenBaoKemuDataModel *keMuModel=(ShenBaoKemuDataModel*)obj;
                [orderNumArray addObject:keMuModel.order_num];
            }
        }];
        PayControllerCell *cellTwo=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        if (cellTwo.yuFuKuanButt.selected) {
            [self payRequet:[orderNumArray objectAtIndex:0]];  //待修改....
        }else
        {
            
        }
        return [RACSignal empty];
    }];
}
-(void)payRequet:(NSString*)orderNum
{
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:orderNum,@"order_num", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:USEPREPAYMONEY params:paramsDic httpMethod:@"POST" block:^(id result) {
         [SVProgressHUD dismiss];
       NSLog(@"result====%@",result);
       LoginModel *tempModel=[LoginModel yy_modelWithDictionary:result];
        if (tempModel.code==0) {
            [self performSegueWithIdentifier:@"PayResultViewController" sender:tempModel];
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 1;
    }else
    {
        if (self.dataArray.count==0) {
            return 2;
        }else
        {
         return self.dataArray.count+1;
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            PayControllerCell *cellThree=[tableView dequeueReusableCellWithIdentifier:@"PayControllerCellThree"];
             cellThree.totalMoneyLabel.text=[NSString stringWithFormat:@"￥%.2f",totalMoney];
            return cellThree;
        }else
        {
            PayControllerCell *cellOne=[tableView dequeueReusableCellWithIdentifier:@"PayControllerCellOne"];
            if ([self.dataArray[0] isKindOfClass:[ShenBaoKemuDataModel class]]) {
                ShenBaoKemuDataModel *tempModel=self.dataArray[0];
              cellOne.orderDetailLabel.text=[NSString stringWithFormat:@"%@",tempModel.order_title];
            }else if ([self.dataArray[0] isKindOfClass:[OrderDetailModel class]]){
                OrderDetailModel *tempModel=self.dataArray[0];
                cellOne.orderDetailLabel.text=[NSString stringWithFormat:@"%@",tempModel.data.item_title];
            }
            else
            {
                OrderListDataModel  *orderModel=[self.dataArray objectAtIndex:indexPath.row-1];
                cellOne.orderDetailLabel.text=[NSString stringWithFormat:@"%@",orderModel.item_title];
            }
            return cellOne;
        }
    }else{
        PayControllerCell *cellTwo=[tableView dequeueReusableCellWithIdentifier:@"PayControllerCellTwo"];
        cellTwo.moneyLabel.attributedText=[self createAttributStringWithString:[NSString stringWithFormat:@"(还剩￥%.2f)",[model.data.money floatValue]] changeString:[NSString stringWithFormat:@"￥%.2f",[model.data.money floatValue]] andAttributDic:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#E9554B"]}];
        if ([model.data.money floatValue]>=totalMoney&&canUsePrepayMoney) {
            cellTwo.yuFuKuanButt.selected=YES;
            cellTwo.yuFuKuanButt.enabled=YES;
            cellTwo.weiXinButt.selected=NO;
        }else
        {
            cellTwo.yuFuKuanButt.selected=NO;
            cellTwo.yuFuKuanButt.enabled=NO;
            cellTwo.weiXinButt.selected=YES;
        }
        return cellTwo;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1&&indexPath.row==0) {
        return 83;
    }else
    {
        return 44;
    }
}
-(void)backToFrontViewController
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:NSClassFromString(@"ShenBaoViewController")]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PayResultViewController *controller=[segue destinationViewController];
    controller.model=sender;
}


@end
