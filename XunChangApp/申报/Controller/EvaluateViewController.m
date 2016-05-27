//
//  EvaluateViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/12.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "EvaluateViewController.h"
#import "HCSStarRatingView.h"
#import "UIPlaceHolderTextView.h"
@interface EvaluateViewController ()
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *wordNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *submittButt;


@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"服务评价";
    [self createNavBackButt];
    self.contentTextView.placeholder=@"请输入评价";
    [self.contentTextView.rac_textSignal subscribeNext:^(id x) {
        NSString *inputWord=x;
        self.wordNumLabel.text=[NSString stringWithFormat:@"%d",inputWord.length];
    }];
    self.submittButt.layer.cornerRadius=5.0f;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (IBAction)starValueChanged:(HCSStarRatingView *)sender {
    self.scoreLabel.text=[NSString stringWithFormat:@"%.0f",sender.value];
}

- (IBAction)submittButtAction:(id)sender {
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.orderNum,@"order_num",self.contentTextView.text==nil?@"":self.contentTextView.text,@"comment",self.scoreLabel.text,@"star", nil];
    [ShenBaoDataRequest requestAFWithURL:EVALUATEORDER params:paramsDic httpMethod:@"POST" block:^(id result) {
         [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        if ([[result objectForKey:@"code"] integerValue]==0) {
            [SVProgressHUD showSuccessWithStatus:@"评价成功" maskType:SVProgressHUDMaskTypeBlack];
            [self backToFrontViewController];
        }else
        {
            [SVProgressHUD  showErrorWithStatus:[result objectForKey:@"message"] maskType:SVProgressHUDMaskTypeBlack];
        }
    } errorBlock:^(NSError *error) {
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
        [SVProgressHUD  showErrorWithStatus:@"网络请求错误了..." maskType:SVProgressHUDMaskTypeBlack];
    } noNetWorking:^(NSString *noNetWorking) {
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
        [SVProgressHUD  showErrorWithStatus:@"没网了..." maskType:SVProgressHUDMaskTypeBlack];
    }];
}
- (IBAction)resignKeyBoard:(UITapGestureRecognizer *)sender {
    [self.contentTextView resignFirstResponder];
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
