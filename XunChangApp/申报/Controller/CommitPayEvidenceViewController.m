//
//  CommitPayEvidenceViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/11.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "CommitPayEvidenceViewController.h"

@interface CommitPayEvidenceViewController ()

@end

@implementation CommitPayEvidenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"提交线下支付凭证";
    [self createNavBackButt];
    // Do any additional setup after loading the view.
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
