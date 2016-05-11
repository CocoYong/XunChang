//
//  PayResultViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/11.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "PayResultViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface PayResultViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;
@property (weak, nonatomic) IBOutlet UILabel *twoLinesLabel;
@property (weak, nonatomic) IBOutlet UILabel *remindLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButt;

@end

@implementation PayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"支付成功";
    [self createNavBackButt:@"黑色"];
    self.backButt.layer.borderColor=[UIColor colorWithHexString:@"#e0e0e0"].CGColor;
    self.backButt.layer.borderWidth=1.0f;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavBarColor:[UIColor colorWithHexString:@"#f8f8f8"]];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]};
    
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
