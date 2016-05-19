//
//  OrdersListViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/10.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "OrdersListViewController.h"
#import "ButtonLabelView.h"
#import "OrderListCell.h"
#import "UIImageView+WebCache.h"
#import "OrderListModel.h"
#import "PayViewController.h"
#import "LoginModel.h"
@interface OrdersListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *payModelDataArray; //最后付款的订单数组
    NSArray *titleArray;
    OrderListModel *model;  //请求回来的总model
    NSInteger itemsNum;   //合并付款后面的计数
}
@property(nonatomic,copy)NSString *status;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *backGrayView;
@property (weak, nonatomic) IBOutlet UIView *alertBackView;
@property (weak, nonatomic) IBOutlet UILabel *alertLable;
@property (weak, nonatomic) IBOutlet UIButton *alertFirstButt;
@property (weak, nonatomic) IBOutlet UIButton *alertSecondButt;

@property (weak, nonatomic) IBOutlet UIView *bottomBackView;

@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *allSelectButt;
@property (weak, nonatomic) IBOutlet UIButton *allPayButt;
@property(nonatomic,assign)CGFloat totalMoneyMark; //标记所有订单加起来多少钱的
@end

@implementation OrdersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申报订单";
    [self createNavBackButt];
    titleArray=@[@"待付款",@"待服务",@"待确认",@"待评价"];
    NSArray *statusArray=@[@"pending",@"start",@"finish",@"signin"];
    //初始化最后付款的数组
    payModelDataArray=[[NSMutableArray alloc]init];
    //首次进入请求数据
    self.status=[statusArray objectAtIndex:_index];
    [self requestOrderListData];
    //顶部五个按钮
    ButtonLabelView *fiveButtView=[[ButtonLabelView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) andTitlesArray:titleArray andDefaultSelectIndex:_index andCallBackBlock:^(UIButton *butt, id model) {
        self.index=butt.tag;
        self.status=[statusArray objectAtIndex:butt.tag];
        [self requestOrderListData];
    }];
    fiveButtView.layer.borderColor=[UIColor colorWithHexString:@"#e0e0e0"].CGColor;
    fiveButtView.layer.borderWidth=1.0;
    [self.view addSubview:fiveButtView];
    //隐藏bottombackView
    self.bottomBackView.hidden=YES;
    self.tableView.height=SCREEN_HEIGHT-104;
    
    [self.allSelectButt setImage:[UIImage imageNamed:@"radio_selected"] forState:UIControlStateSelected];
    [self.allSelectButt setImage:[UIImage imageNamed:@"radio_normal"] forState:UIControlStateNormal];
    //全选按钮
    self.allSelectButt.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        self.allSelectButt.selected=!self.allSelectButt.selected;
        model.totalPayMoney=0;
        if (self.allSelectButt.selected) {
            [model.datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                OrderListDataModel *tempModel=(OrderListDataModel*)obj;
                tempModel.radioButtSelect=YES;
                model.totalPayMoney+=[tempModel.total_money floatValue];
                self.totalMoneyMark=model.totalPayMoney;
            }];
            self.allSelectButt.selected=YES;
        }else
        {
            [model.datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                OrderListDataModel *tempModel=(OrderListDataModel*)obj;
                tempModel.radioButtSelect=NO;
            }];
            self.allSelectButt.selected=NO;
        }
        self.totalMoneyLabel.text=[NSString stringWithFormat:@"￥%.2f",model.totalPayMoney];
        [self.tableView reloadData];
        return [RACSignal empty];
    }];
    //观察合计金额的变化....
    [RACObserve(self, totalMoneyLabel.text)subscribeNext:^(id x) {
        NSString *moneyString=[x substringFromIndex:1];
        if ([moneyString floatValue]==0&&self.totalMoneyMark==0) {
            self.allSelectButt.selected=NO;
            self.bottomBackView.hidden=YES;
            self.tableView.height=SCREEN_HEIGHT-104;
        }else if ([moneyString floatValue]!=self.totalMoneyMark) {
            self.allSelectButt.selected=NO;
            itemsNum=0;
            [model.datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              OrderListDataModel *tempModel=(OrderListDataModel*)obj;
                if (tempModel.radioButtSelect) {
                    itemsNum++;
                [self.allPayButt setAttributedTitle:[self createAttributStringWithString:[NSString stringWithFormat:@"合并付款(%d)",itemsNum] changeString:[NSString stringWithFormat:@"(%d)",itemsNum] andAttributDic:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}] forState:UIControlStateNormal];
                }
            }];
        }else{
            self.allSelectButt.selected=YES;
            itemsNum=model.datas.count;
            [self.allPayButt setAttributedTitle:[self createAttributStringWithString:[NSString stringWithFormat:@"合并付款(%d)",itemsNum] changeString:[NSString stringWithFormat:@"(%d)",itemsNum] andAttributDic:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}] forState:UIControlStateNormal];
        }
    }];
    //合并付款按钮
     self.allPayButt.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
         NSString *tempString=[self.totalMoneyLabel.text substringFromIndex:1];
         if ([tempString floatValue]==0) {
             [SVProgressHUD showErrorWithStatus:@"您一项都没选呢,为什么项目付款啊?" maskType:SVProgressHUDMaskTypeClear];
         }else
         {
             [model.datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 OrderListDataModel *tempModel=(OrderListDataModel*)obj;
                 if (tempModel.radioButtSelect) {
                     [payModelDataArray addObject:tempModel];
                 }
             }];
             [self performSegueWithIdentifier:@"PayViewController" sender:self];
         }
         return [RACSignal empty];
     }];
}
-(void)requestOrderListData
{
    self.bottomBackView.hidden=YES;
    self.tableView.height=SCREEN_HEIGHT-104;
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.status,@"task_status", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:@"api/xcapply_mock/orderList" params:paramsDic httpMethod:@"POST" block:^(id result) {
         [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        NSDictionary *resultDic=(NSDictionary*)result;
        model=[OrderListModel yy_modelWithDictionary:resultDic];
        model.datas=[NSArray yy_modelArrayWithClass:[OrderListDataModel class] json:[resultDic objectForKey:@"data"]];
        OrderListDataModel *secondModel=[model.datas objectAtIndex:0];
        self.totalMoneyLabel.text=[NSString stringWithFormat:@"￥%.2f",model.totalPayMoney];
        NSLog(@"secondModel=====%@",secondModel.checker_realname);
        if (model.code==0) {
            [self.tableView reloadData];
        }else if (model.code==9999)
        {
            [SVProgressHUD showWithStatus:model.message];
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
    self.view.backgroundColor=[UIColor colorWithHexString:@"#EFF0F1"];
    [payModelDataArray removeAllObjects];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return model.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderListCell"];
    OrderListDataModel *secondModel=[model.datas objectAtIndex:indexPath.row];
    cell.orderNumLabel.text=secondModel.order_num;
    [cell.stadiumImageView sd_setImageWithURL:[NSURL URLWithString:secondModel.type_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:secondModel.object_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
    cell.stadiumNameLabel.text=secondModel.object_address;
    cell.goodsNameLabel.text=secondModel.item_title;
    cell.goodsNumLabel.text=[NSString stringWithFormat:@"x%d",[secondModel.num integerValue]];
    cell.stadiumNameLabel.text=secondModel.item_title;
    cell.startTimeLabel.text=[NSString stringWithFormat:@"开始使用时间:%@",secondModel.start_time];
    cell.moneyLabel.text=[NSString stringWithFormat:@"￥%.2f",[secondModel.total_money floatValue]];
    ITTDINFO(@"indexpathrow===%d,secondeModel.radioselect==%d",indexPath.row,secondModel.radioButtSelect);
    //cell-radioButtAction
    cell.radioButt.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        cell.radioButt.selected=!cell.radioButt.selected;
        if (cell.radioButt.selected) {
            secondModel.radioButtSelect=YES;
            cell.radioButt.selected=YES;
            model.totalPayMoney +=[secondModel.total_money floatValue];
            self.bottomBackView.hidden=NO;
            self.tableView.height=SCREEN_HEIGHT-104-53;
        }else
        {
            secondModel.radioButtSelect=NO;
            cell.radioButt.selected=NO;
            model.totalPayMoney -=[secondModel.total_money floatValue];
        }
        self.totalMoneyLabel.text=[NSString stringWithFormat:@"￥%.2f",model.totalPayMoney];
        return [RACSignal empty];
    }];
    if (secondModel.radioButtSelect) {
        cell.radioButt.selected=YES;
    }else
    {
         cell.radioButt.selected=NO;
    }
    
    //cell+cancelButt+payButt+deletButt+action
    [cell.payButt addTarget:self action:@selector(payButtAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deletButt addTarget:self action:@selector(deletButtAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cancelButt addTarget:self action:@selector(cancelButtAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.deletButt.tag=indexPath.row*4+1;
    cell.cancelButt.tag=indexPath.row*4+2;
    cell.payButt.tag=indexPath.row*4+3;
    
    if (self.index==0){
        cell.radioButt.hidden=NO;
        cell.startTimeLabel.hidden=NO;
        cell.deletButt.hidden=YES;
        [cell.payButt setBackgroundColor:[UIColor colorWithHexString:@"#D16A38"]];
        [cell.payButt setTitle:@"付款" forState:UIControlStateNormal];
        [cell.cancelButt setTitle:@"取消订单" forState:UIControlStateNormal];
        [cell.payButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.statusLabel.textColor=[UIColor colorWithHexString:@"#D16A38"];
        cell.statusLabel.text=@"待付款";
    }else if (self.index==1)
    {
        cell.radioButt.hidden=YES;
        cell.startTimeLabel.hidden=NO;
        cell.deletButt.hidden=YES;
        cell.statusLabel.textColor=[UIColor colorWithHexString:@"#8AAC7B"];
        cell.statusLabel.text=@"付款成功";
        [cell.payButt setTitle:@"投诉" forState:UIControlStateNormal];
        [cell.payButt setBackgroundColor:[UIColor colorWithHexString:@"#D16A38"]];
        [cell.payButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.cancelButt setTitle:@"联系服务" forState:UIControlStateNormal];
    }else if (self.index==2)
    {
        cell.startTimeLabel.hidden=YES;
        cell.radioButt.hidden=YES;
        cell.deletButt.hidden=YES;
        cell.statusLabel.text=@"等待确定";
        [cell.payButt setTitle:@"签收" forState:UIControlStateNormal];
        [cell.payButt setBackgroundColor:[UIColor colorWithHexString:@"#D16A38"]];
        [cell.payButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.cancelButt setTitle:@"投诉" forState:UIControlStateNormal];
    }else
    {
        cell.radioButt.hidden=YES;
        cell.startTimeLabel.hidden=YES;
        cell.statusLabel.text=@"交易成功";
        if ([secondModel.is_comment isEqualToString:@"Y"]) {
            [cell.payButt setBackgroundColor:[UIColor whiteColor]];
            [cell.payButt setTitle:@"投诉" forState:UIControlStateNormal];
            [cell.payButt setTitleColor:[UIColor colorWithHexString:@"#A5A6A7"] forState:UIControlStateNormal];
            cell.payButt.layer.borderColor=[UIColor colorWithHexString:@"#DCDDDD"].CGColor;
            cell.payButt.layer.borderWidth=1.0f;
            [cell.cancelButt setTitle:@"删除订单" forState:UIControlStateNormal];
        }else
        {
            [cell.payButt setBackgroundColor:[UIColor colorWithHexString:@"#8AAC7B"]];
            [cell.payButt setTitle:@"评价" forState:UIControlStateNormal];
            [cell.cancelButt setTitle:@"投诉" forState:UIControlStateNormal];
            cell.deletButt.hidden=NO;
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 224;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (self.bottomBackView.hidden==YES) {
        self.tableView.height=SCREEN_HEIGHT-104;
    }else
    {
        self.tableView.height=SCREEN_HEIGHT-104-53;
    }
    [self.view layoutIfNeeded];
}

- (void)payButtAction:(UIButton*)sender {
    if ([sender.titleLabel.text isEqualToString:@"付款"]) {
    [payModelDataArray addObject:[model.datas objectAtIndex:sender.tag/4]];
    [self performSegueWithIdentifier:@"PayViewController" sender:self];
    }else if ([sender.titleLabel.text isEqualToString:@"签收"])
    {
     OrderListDataModel *tempModel=[model.datas objectAtIndex:sender.tag/4];
        [self recieveGoodsRequest:tempModel.order_num];
    }else if([sender.titleLabel.text isEqualToString:@"投诉"])
    {
        
    }else if ([sender.titleLabel.text isEqualToString:@"评价"])
    {
        
    }
}
- (void)cancelButtAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"联系服务"]) {
        
    }else if ([sender.titleLabel.text isEqualToString:@"取消订单"])
    {
        
    }else if([sender.titleLabel.text isEqualToString:@"投诉"])
    {
        
    }else if ([sender.titleLabel.text isEqualToString:@"删除订单"])
    {
        
    }
}
-(void)deletButtAction:(UIButton*)sender
{
    
}
-(void)recieveGoodsRequest:(NSString*)orderNum
{
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:orderNum,@"order_num", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:@"api/xcapply_mock/orderSign" params:paramsDic httpMethod:@"POST" block:^(id result) {
         [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        NSDictionary *resultDic=(NSDictionary*)result;
       LoginModel *tempModel=[LoginModel yy_modelWithDictionary:resultDic];
        if (tempModel.code==0) {
            self.backGrayView.hidden=NO;
            self.alertBackView.hidden=NO;
        }else if (tempModel.code==9999)
        {
            [SVProgressHUD showWithStatus:tempModel.message];
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
- (IBAction)alertHiddenButtAction:(UIButton*)sender {
    self.backGrayView.hidden=YES;
    self.alertBackView.hidden=YES;
}
- (IBAction)alertSecondButtAction:(UIButton*)sender {
    if ([sender.titleLabel.text isEqualToString:@"现在评价"]) {
        
    }
}
- (IBAction)alertFirstButtAction:(UIButton*)sender {
    if ([sender.titleLabel.text isEqualToString:@"我要投诉"]) {
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue destinationViewController] isKindOfClass:NSClassFromString(@"PayViewController")]) {
        PayViewController *payController=[segue destinationViewController];
        payController.dataArray=[payModelDataArray copy];
    }
}


@end
