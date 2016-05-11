//
//  BaseViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/5.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]};
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)setNavBarColor:(UIColor*)color
{
    self.navigationController.navigationBar.barTintColor=color;
}
-(void)createNavBackButt:(NSString*)backColor
{
    UIButton *leftButt=[UIButton buttonWithType:UIButtonTypeCustom];
    
    leftButt.frame=CGRectMake(0, 0, 15, 20);
    [leftButt setImage:[UIImage imageNamed:@"btn_back_white"] forState:UIControlStateNormal];
    if ([backColor isEqualToString:@"黑色"]) {
    [leftButt setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    }
    [leftButt addTarget:self action:@selector(backToFrontViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButt];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=leftItem;
}
-(void)backToFrontViewController
{
    [self.navigationController popViewControllerAnimated:YES];
   
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
