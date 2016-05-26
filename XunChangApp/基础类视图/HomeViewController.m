//
//  HomeViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/6.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewItemCell.h"
#import "UIImageView+WebCache.h"
#import "ShenBaoViewController.h"
#import "UserCenterModel.h"
#import "ChangJingViewController.h"
#import "YuFuKuanManagerViewController.h"
#import "LoginModel.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UserCenterModel *userModel;
    NSTimer *requestTimer;
    NSString *sceneID;
}
@property (weak, nonatomic) IBOutlet UILabel *remindLabel;
@property (weak, nonatomic) IBOutlet UIButton *userInfoButt;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIView *userInfoView;
@property (weak, nonatomic) IBOutlet UIView *changJIngView;
@property (weak, nonatomic) IBOutlet UICollectionView *itemCollectionView;

@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *changJingNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *changJingLogoImageView;
@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"会员主页";
    self.userPhotoImageView.clipsToBounds=YES;
    self.userPhotoImageView.layer.cornerRadius=20;
    self.userPhotoImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    self.userPhotoImageView.layer.borderWidth=1.0f;
    
    UIImageView *logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 28)];
    logoImageView.image=[UIImage imageNamed:@"img_czlogo"];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:logoImageView];
    
    //测试专用
    [USER_DEFAULT setObject:@"8fd4bcd74eecfcd96d8b34bba1e7644c" forKey:@"user_token"];
    [USER_DEFAULT setObject:@"12" forKey:@"scene_id"];
    [USER_DEFAULT setObject:@"app" forKey:@"request_from"];
    
    requestTimer=[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(requestUserCenterData) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:requestTimer forMode:NSRunLoopCommonModes];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"uer_token-====%@",[USER_DEFAULT objectForKey:@"user_token"]);
    if ([USER_DEFAULT objectForKey:@"user_token"]==nil||[[USER_DEFAULT objectForKey:@"user_token"] isEqualToString:@""]) {
        [self performSegueWithIdentifier:@"LoginViewController" sender:self];
    }
    if ([[USER_DEFAULT objectForKey:@"status"] isEqualToString:@"register"]) {
        [self performSegueWithIdentifier:@"SubmittUserInfoViewController" sender:self];
    }
    
    [requestTimer setFireDate:[NSDate distantPast]];
}
-(void)requestUserCenterData
{
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:USERCENTER params:nil httpMethod:@"POST" block:^(id result) {
        [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        userModel=[UserCenterModel yy_modelWithDictionary:result];
        userModel.data.actions=[NSArray yy_modelArrayWithClass:[ActionsModel class] json:[[result objectForKey:@"data"] objectForKey:@"actions"]];
        userModel.data.scenes=[NSArray yy_modelArrayWithClass:[ScenesModel class] json:[[result objectForKey:@"data"] objectForKey:@"scenes"]];
            if (userModel.code==0) {
            [self configeUIData];
            [self.itemCollectionView reloadData];
        }else
        {
            [SVProgressHUD  showErrorWithStatus:userModel.message maskType:SVProgressHUDMaskTypeBlack];
        }
    } errorBlock:^(NSError *error) {
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
        [SVProgressHUD  showErrorWithStatus:@"网络请求错误了..." maskType:SVProgressHUDMaskTypeBlack];
    } noNetWorking:^(NSString *noNetWorking) {
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
        [SVProgressHUD  showErrorWithStatus:@"没网了..." maskType:SVProgressHUDMaskTypeBlack];
    }];
}
-(void)configeUIData
{
    [self.userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:userModel.data.userinfo.avatar] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
    self.nickNameLabel.text=[NSString stringWithFormat:@"昵称:%@",userModel.data.userinfo.nickname];
    self.userCompanyLabel.text=[NSString stringWithFormat:@"手机号:%@",userModel.data.userinfo.tel];
    [self.changJingLogoImageView sd_setImageWithURL:[NSURL URLWithString:userModel.data.scene_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
    self.changJingNameLabel.text=userModel.data.scene_title;
    
    self.userInfoButt.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        [self performSegueWithIdentifier:@"SubmittUserInfoViewController" sender:self];
        return [RACSignal empty];
    }];
//    if ([[USER_DEFAULT objectForKey:@"status"] isEqualToString:@"login"]) {
//        self.userInfoButt.hidden=NO;
//    }else
//    {
//        self.userInfoButt.hidden=YES;
//    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [userModel.data.actions count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewItemCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewItemCell" forIndexPath:indexPath];
    ActionsModel *actionModel=[userModel.data.actions objectAtIndex:indexPath.row];
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:actionModel.icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
    cell.nameLabel.text=actionModel.title;
    cell.messageNumLabel.layer.cornerRadius=6.0f;
    if ([actionModel.message_count integerValue]>0) {
        cell.messageNumLabel.hidden=NO;
        cell.messageNumLabel.text=[NSString stringWithFormat:@"%d",[actionModel.message_count integerValue]];
    }else
    {
      cell.messageNumLabel.hidden=YES;
    }
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-5)/4, 81);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   ActionsModel *actionModel=[userModel.data.actions objectAtIndex:indexPath.row];
    [self clearMessageCount:actionModel.name];
    
}
-(void)clearMessageCount:(NSString *)objectType
{
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:objectType,@"type", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:CLEARMESSAGE params:paramsDic httpMethod:@"POST" block:^(id result) {
        [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        LoginModel *resultModel=[LoginModel yy_modelWithDictionary:result];
        if (resultModel.code==0) {
//            if ([objectType isEqualToString:@"申报"]){
                if ([objectType isEqualToString:@"apply_guest"]) {
                    [self performSegueWithIdentifier:@"ShenBaoController" sender:self];
                }else if([objectType isEqualToString:@"apply_staff"])
                {
                    [self performSegueWithIdentifier:@"ZhiXingRenOrderListViewController" sender:self];
                }
//            }
//            else if ([objectType isEqualToString:@"xunchang"]){
//                [self performSegueWithIdentifier:@"XunChangController" sender:self];
//            }
//            else if([objectType isEqualToString:@"stat"]){
//                [self performSegueWithIdentifier:@"TongJiViewController" sender:self];
//            }
//            else if([objectType isEqualToString:@"message"]){
//                [self performSegueWithIdentifier:@"MessagerViewController" sender:self];
//            }
//            else if([objectType isEqualToString:@"xunchang_control"]){
//                [self performSegueWithIdentifier:@"XunChangManagerViewController" sender:self];
//            }else if([objectType isEqualToString:@"监管记录"]){
//                [self performSegueWithIdentifier:@"JianGuanJiluViewController" sender:self];
//            }
//            else if([objectType isEqualToString:@"整改管理"]){
//                [self performSegueWithIdentifier:@"ZhenGaiViewController" sender:self];
//            }
                else if([objectType isEqualToString:@"perpay_ctrl"])
                {
                [self performSegueWithIdentifier:@"YuFuKuanManagerViewController" sender:self];
                }
        }else
        {
            [SVProgressHUD  showErrorWithStatus:userModel.message maskType:SVProgressHUDMaskTypeBlack];
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
-(void)viewDidDisappear:(BOOL)animated
{
    [requestTimer setFireDate:[NSDate distantFuture]];
}
-(void)viewDidLayoutSubviews
{
    
}
#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:NSClassFromString(@"ShenBaoViewController")]) {
        ShenBaoViewController *viewController=[segue destinationViewController];
        viewController.dataModel=userModel.data;
    }
    if ([[segue destinationViewController] isKindOfClass:NSClassFromString(@"ChangJingViewController")]) {
        ChangJingViewController *changJingController=[segue destinationViewController];
        changJingController.dataArray=userModel.data.scenes;
        changJingController.sceneBlock=^(ScenesModel *sceneModel){
            sceneID=sceneModel.id;
            [USER_DEFAULT setObject:sceneID forKey:@"scene_id"];
            [self requestUserCenterData];
        };
    }
//    if ([[segue destinationViewController] isKindOfClass:NSClassFromString(@"YuFuKuanManagerViewController")]) {
//        YuFuKuanManagerViewController *viewController=[segue destinationViewController];
//    }
    NSLog(@"sender  =%@",sender);
    NSLog(@"distinationViewcontroller=%@",NSStringFromClass([[segue destinationViewController] class]));
}
@end
