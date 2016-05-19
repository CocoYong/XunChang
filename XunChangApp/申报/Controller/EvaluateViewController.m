//
//  EvaluateViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/12.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "EvaluateViewController.h"
#import "HCSStarRatingView.h"
@interface EvaluateViewController ()
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *wordNumLabel;


@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"服务评价";
    [self createNavBackButt];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (IBAction)submittButtAction:(id)sender {
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"123",@"order_num",@"这样好吗?",@"comment",@"5",@"star", nil];
    [ShenBaoDataRequest requestAFWithURL:@"api/xcapply_mock/comment" params:paramsDic httpMethod:@"POST" block:^(id result) {
         [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        NSDictionary *resultDic=(NSDictionary*)result;
        if ([[resultDic objectForKey:@"code"] integerValue]==0) {
            [SVProgressHUD showWithStatus:[resultDic objectForKey:@"message"]];
        }else
        {
            [SVProgressHUD  showWithStatus:[resultDic objectForKey:@"message"]];
        }
    } errorBlock:^(NSError *error) {
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
        [SVProgressHUD  showErrorWithStatus:@"网络请求错误了..." maskType:SVProgressHUDMaskTypeBlack];
    } noNetWorking:^(NSString *noNetWorking) {
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
        [SVProgressHUD  showErrorWithStatus:@"没网了..." maskType:SVProgressHUDMaskTypeBlack];
    }];
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
