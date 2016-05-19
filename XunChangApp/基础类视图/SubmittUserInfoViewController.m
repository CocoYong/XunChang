//
//  SubmittUserInfoViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/16.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "SubmittUserInfoViewController.h"

@interface SubmittUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButt;
@property (weak, nonatomic) IBOutlet UIButton *manButt;
@property (weak, nonatomic) IBOutlet UIButton *womanButt;
@property(nonatomic,copy)NSString *sex;
@end

@implementation SubmittUserInfoViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self createNavBackButt];
    self.title=@"基本资料";
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"MAN",@"sex",@"coco",@"nickname", nil];
    [SVProgressHUD showWithStatus:@"正在上传数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestUpLoadImageurl:@"api/user/bindUserInfo" params:paramsDic httpMethod:@"POST" imageData:[UIImage imageNamed:@"icon_cpmrt"] fileName:@"icon_cpmrt" iamgeUrlParams:@"avatar" successCallBackBlock:^(id result) {
        [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        
    } errorBlock:^(NSError *error) {
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
        [SVProgressHUD  showErrorWithStatus:@"网络请求错误了..." maskType:SVProgressHUDMaskTypeBlack];
    } noNetworkingBlock:^(NSString *noNetWorking) {
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
        [SVProgressHUD  showErrorWithStatus:@"没网了..." maskType:SVProgressHUDMaskTypeBlack];
    }];
}
-(void)backToFrontViewController
{
    [USER_DEFAULT setObject:@"login" forKey:@"status"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addPhotoButtAction:(UIButton *)sender {
    
}
- (IBAction)manButtAction:(UIButton *)sender {
    sender.selected=!sender.selected;
    if (sender.selected) {
      self.sex=@"MAN";
    }else
    {
        if (!self.womanButt.selected) {
            self.sex=@"SECRECY";
        }
    }
}
- (IBAction)womanButtAction:(UIButton *)sender {
    sender.selected=!sender.selected;
    if (sender.selected) {
        self.sex=@"WOMAN";
    }else
    {
        if (!self.manButt.selected) {
          self.sex=@"SECRECY";
        }
    }
}
- (IBAction)submittUserInfoAction:(UIButton *)sender {
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
