//
//  AboutXunChangViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/26.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "AboutXunChangViewController.h"

@interface AboutXunChangViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation AboutXunChangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBackButt];
    if ([self.title isEqualToString:@"关于巡场"]) {
        NSURLRequest *resquest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.51kcwc.com/index/about/index"]];
        [self.webView loadRequest:resquest];
    }else
    {
        NSURLRequest *resquest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.51kcwc.com/index/about/userAgreementr"]];
        [self.webView loadRequest:resquest];
    }
}
-(void)backToFrontViewController
{
    if ([self.title isEqualToString:@"关于巡场"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
