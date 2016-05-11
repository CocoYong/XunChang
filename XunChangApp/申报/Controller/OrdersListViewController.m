//
//  OrdersListViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/10.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "OrdersListViewController.h"
#import "ButtonLabelView.h"
#import <QuartzCore/QuartzCore.h>
@interface OrdersListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation OrdersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申报订单";
    [self createNavBackButt:@"白色"];
    NSArray *titleArray=@[@"待审核",@"待付款",@"待服务",@"待确认",@"待评价"];
    ButtonLabelView *fiveButtView=[[ButtonLabelView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) andTitlesArray:titleArray andDefaultSelectIndex:1 andCallBackBlock:^(id butt, id model) {
        NSLog(@"wakakakakkak");
    }];
    fiveButtView.layer.borderColor=[UIColor colorWithHexString:@"#e0e0e0"].CGColor;
    fiveButtView.layer.borderWidth=1.0;
    [self.view addSubview:fiveButtView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavBarColor:[UIColor colorWithHexString:@"#6f9c57"]];
    self.view.backgroundColor=[UIColor whiteColor];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:@"OrderListCell"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
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
