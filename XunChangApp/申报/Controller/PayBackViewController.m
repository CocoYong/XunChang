//
//  PayBackViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/11.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "PayBackViewController.h"

@interface PayBackViewController ()
@property (weak, nonatomic) IBOutlet UITextField *payBackReasonTextfield;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextfield;

@end

@implementation PayBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申请退款";
    [self createNavBackButt];
    // Do any additional setup after loading the view.
}
- (IBAction)takePhotoAction:(id)sender {
}
- (IBAction)selectPhotoAction:(id)sender {
}
- (IBAction)submitAction:(id)sender {
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
