//
//  LoginViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/14.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseViewController+CommonFuncs.h"
#import "LoginModel.h"
#import "RegistOrLogin.h"
@interface LoginViewController ()
{
    NSInteger seconds;
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyTextField;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeButt;
@property (weak, nonatomic) IBOutlet UILabel *verifySecondLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButt;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    seconds=60;
    [[self.telephoneNumTextField.rac_textSignal filter:^BOOL(id value) {
        return ![self.telephoneNumTextField isFirstResponder];
    }]
     subscribeNext:^(id x) {
         if (![x isEqualToString:@""]){
             if (![self validatePhoneMobile:x]){
                 [SVProgressHUD showErrorWithStatus:@"手机号码格式错误!" maskType:SVProgressHUDMaskTypeBlack];
             }
         }
    }];
    //获取验证码按钮
    self.getVerifyCodeButt.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        if (![self validatePhoneMobile:self.telephoneNumTextField.text]){
            [SVProgressHUD showErrorWithStatus:@"手机号码格式错误!" maskType:SVProgressHUDMaskTypeBlack];
        }else
        {
            [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
            NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.telephoneNumTextField.text,@"tel", nil];
            [ShenBaoDataRequest requestAFWithURL:@"api/main/getMobileVerify" params:paramsDic httpMethod:@"POST" block:^(id result) {
                 [SVProgressHUD dismiss];
                LoginModel *model=[LoginModel yy_modelWithDictionary:result];
                if (model.code==0) {
                 [self startTimerCount];
                }else if (model.code==9999)
                {
                   [SVProgressHUD  showErrorWithStatus:model.message maskType:SVProgressHUDMaskTypeBlack];
                }else if(model.code==1001)
                {
                    [USER_DEFAULT removeObjectForKey:@"user_token"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            } errorBlock:^(NSError *error) {
                [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
                [SVProgressHUD  showErrorWithStatus:@"网络请求错误了..." maskType:SVProgressHUDMaskTypeBlack];
            } noNetWorking:^(NSString *noNetWorking) {
                [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
                [SVProgressHUD  showErrorWithStatus:@"没网了..." maskType:SVProgressHUDMaskTypeBlack];
            }];
        }
      return [RACSignal empty];
    }];
    //登录按钮
    self.loginButt.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.telephoneNumTextField.text,@"tel",self.verifyTextField.text,@"code", nil];
        [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
        [ShenBaoDataRequest requestAFWithURL:@"api/main/login" params:paramsDic httpMethod:@"POST" block:^(id result) {
             [SVProgressHUD dismiss];
            RegistOrLogin *model=[RegistOrLogin yy_modelWithDictionary:result];
            if (model.code==0) {
                [USER_DEFAULT setObject:model.data.user_token forKey:@"user_token"];
                [USER_DEFAULT setObject:model.data.status forKey:@"status"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else if (model.code==9999)
            {
                [SVProgressHUD showErrorWithStatus:model.message maskType:SVProgressHUDMaskTypeBlack];
            }else
            {
                
            }
        } errorBlock:^(NSError *error) {
            [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
            [SVProgressHUD  showErrorWithStatus:@"网络请求错误了..." maskType:SVProgressHUDMaskTypeBlack];
        } noNetWorking:^(NSString *noNetWorking) {
            [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
            [SVProgressHUD  showErrorWithStatus:@"没网了..." maskType:SVProgressHUDMaskTypeBlack];
        }];
        return [RACSignal empty];
    }];
}
- (IBAction)resignKeyBoard:(id)sender {
    [self.telephoneNumTextField resignFirstResponder];
    [self.verifyTextField resignFirstResponder];
}
-(void)startTimerCount
{
   timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
}
-(void)countTime
{
    seconds--;
    self.verifySecondLabel.text=[NSString stringWithFormat:@"%dS",seconds];
    if (seconds<=0) {
        [timer invalidate];
        seconds=60;
        self.verifySecondLabel.text=@"获取验证码";
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
