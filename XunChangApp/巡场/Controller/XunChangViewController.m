//
//  XunChangViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/9.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "XunChangViewController.h"

@interface XunChangViewController ()

@end

@implementation XunChangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"巡场";
    [self createNavBackButt];
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    
}
@end
