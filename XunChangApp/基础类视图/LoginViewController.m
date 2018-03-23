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
#import "JPUSHService.h"
#import "AboutXunChangViewController.h"
@interface LoginViewController ()
{
    NSInteger seconds;
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (weak, nonatomic) IBOutlet UIView *textFieldBackView;

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyTextField;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeButt;
@property (weak, nonatomic) IBOutlet UILabel *verifySecondLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButt;
@property (weak, nonatomic) IBOutlet UIButton *protocolButt;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textFieldBackView.layer.borderColor=[UIColor colorWithHexString:@"#E6E7EA"].CGColor;
    self.textFieldBackView.layer.borderWidth=1.0f;
    [self.protocolButt setImage:[UIImage imageNamed:@"radio_normal"] forState:UIControlStateNormal];
    [self.protocolButt setImage:[UIImage imageNamed:@"icon_green"] forState:UIControlStateSelected];
    self.protocolButt.selected=YES;
    self.loginButt.layer.cornerRadius=4.0f;
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
            [ShenBaoDataRequest requestAFWithURL:GETMOBILEVERIFY params:paramsDic httpMethod:@"POST" block:^(id result) {
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
        if (!self.protocolButt.selected) {
            [SVProgressHUD showErrorWithStatus:@"未勾选协议" maskType:SVProgressHUDMaskTypeBlack];
            return [RACSignal empty];
        }
        NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.telephoneNumTextField.text,@"tel",self.verifyTextField.text,@"code", nil];
        [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
        [ShenBaoDataRequest requestAFWithURL:LOGINORREGISTER params:paramsDic httpMethod:@"POST" block:^(id result) {
             [SVProgressHUD dismiss];
            NSLog(@"result===%@",result);
            RegistOrLogin *model=[RegistOrLogin yy_modelWithDictionary:result];
//            if (model.code==0) {
//                [USER_DEFAULT setObject:model.data.user_token forKey:@"user_token"];
//                [USER_DEFAULT setObject:model.data.status forKey:@"status"];
//                [USER_DEFAULT setObject:model.data.id forKey:@"user_id"];
//                [self registerJPUSH:[JPUSHService registrationID]];
                [self dismissViewControllerAnimated:YES completion:nil];
//            }else if (model.code==9999)
//            {
//                [SVProgressHUD showErrorWithStatus:model.message maskType:SVProgressHUDMaskTypeBlack];
//            }else
//            {
//                
//            }
        } errorBlock:^(NSError *error) {
            [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
            [self dismissViewControllerAnimated:YES completion:nil];

//            [SVProgressHUD  showErrorWithStatus:@"网络请求错误了..." maskType:SVProgressHUDMaskTypeBlack];
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

-(void)registerJPUSH:(NSString*)register_id
{
    
    NSString *user_id=[USER_DEFAULT objectForKey:@"user_id"];
    [JPUSHService setTags:[NSSet setWithObject:user_id] alias:user_id fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"设置成功iResCode==%d",iResCode);
    }];
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:user_id,@"user_id",@"ios",@"type",register_id,@"reg_id", nil];
    [ShenBaoDataRequest requestAFWithURL:BINDAPP params:paramsDic httpMethod:@"POST" block:^(id result) {
        LoginModel *tempModel=[LoginModel yy_modelWithDictionary:result];
        if (tempModel.code==0) {
            NSLog(@"注册成功");
        }
    } errorBlock:^(NSError *error) {
        
    } noNetWorking:^(NSString *noNetWorking) {
        
    }];
}

- (IBAction)userProtocolButtAction:(UIButton *)sender {
    UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AboutXunChangViewController *aboutController=[mainStoryBoard instantiateViewControllerWithIdentifier:@"AboutXunChangViewController"];
    aboutController.title=@"用户协议";
    UINavigationController *navigationController=[[UINavigationController alloc]
        initWithRootViewController:aboutController];
    navigationController.navigationBar.tintColor=[UIColor colorWithHexString:@"#F5F6F7"];
    [self showViewController:navigationController sender:self];
}
- (IBAction)protocolButtAction:(UIButton *)sender {
    sender.selected=!sender.selected;
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
