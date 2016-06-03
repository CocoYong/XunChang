//
//  PayResultViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/11.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "PayResultViewController.h"
#import "OrdersListViewController.h"
@interface PayResultViewController ()
{
    __block BOOL haveOrderListController;
}
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;
@property (weak, nonatomic) IBOutlet UILabel *twoLinesLabel;
@property (weak, nonatomic) IBOutlet UILabel *remindLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButt;
@property (weak, nonatomic) IBOutlet UIButton *stateButt;

@end

@implementation PayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.model.code==0&&[self.model.message isEqualToString:@"success"]) {
      self.title=@"支付成功";
    }else
    {
      self.title=@"支付失败";
    }
    [self createNavBackButt];
    self.stateButt.layer.cornerRadius=3.0f;
    self.backButt.layer.cornerRadius=3.0f;
    if (self.model.code==0&&[self.model.message isEqualToString:@"success"]) {
        self.resultImageView.image=[UIImage imageNamed:@"icons_success"];
        self.twoLinesLabel.text=@"恭喜您!订单支付成功!";
        self.remindLabel.attributedText=[self createAttributStringWithString:@"请进入\"会员中心-申报-申报订单\"查看申报订单状态" changeString:@"会员中心-申报-申报订单" andAttributDic:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#F99647"]}];
        [self.stateButt setTitle:@"查看申报" forState:UIControlStateNormal];
    }else
    {
        self.resultImageView.image=[UIImage imageNamed:@"icons_fail"];
        self.twoLinesLabel.text=@"抱歉!订单支付失败!";
        self.remindLabel.attributedText=[self createAttributStringWithString:@"请进入\"会员中心-申报-待付款\"完成订单支付" changeString:@"会员中心-申报-待付款" andAttributDic:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#F99647"]}];
        [self.stateButt setTitle:@"去付款" forState:UIControlStateNormal];
    }
    self.stateButt.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        //先判断之前是否有订单列表页  有的话就饭回到订单列表页没有的话就创建一个并且push
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:NSClassFromString(@"OrdersListViewController")]) {
                haveOrderListController=YES;
            }
        }
        if (haveOrderListController) {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:NSClassFromString(@"OrdersListViewController")]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }else{
            UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            OrdersListViewController *orderListController=[mainStoryboard instantiateViewControllerWithIdentifier:@"OrdersListViewController"];
            orderListController.index=2;
            [self showViewController:orderListController sender:self];
        }
        return [RACSignal empty];
    }];
    self.backButt.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        for (UIViewController *contrller in self.navigationController.viewControllers) {
            if ([contrller isKindOfClass:NSClassFromString(@"HomeViewController")]) {
                [self.navigationController popToViewController:contrller animated:YES];
            }
        }
        return [RACSignal empty];
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
}
-(void)backToFrontViewController
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:NSClassFromString(@"ShenBaoViewController")]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
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
}


@end
