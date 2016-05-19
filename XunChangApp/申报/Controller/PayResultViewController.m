//
//  PayResultViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/11.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "PayResultViewController.h"
@interface PayResultViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;
@property (weak, nonatomic) IBOutlet UILabel *twoLinesLabel;
@property (weak, nonatomic) IBOutlet UILabel *remindLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButt;
@property (weak, nonatomic) IBOutlet UIButton *stateButt;

@end

@implementation PayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.model.message;
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
        for (UIViewController *contrller in self.navigationController.viewControllers) {
            if ([contrller isKindOfClass:NSClassFromString(@"OrdersListViewController")]) {
                [self.navigationController popToViewController:contrller animated:YES];
            }
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
