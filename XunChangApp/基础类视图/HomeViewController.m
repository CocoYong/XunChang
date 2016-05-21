//
//  HomeViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/6.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "HomeViewController.h"
#import "CollectionBaseModel.h"
#import "HomeCollectionViewItemCell.h"
#import "UIImageView+WebCache.h"
#import "ShenBaoViewController.h"
#import "UserCenterModel.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UserCenterModel *userModel;
    NSTimer *requestTimer;
}
@property (weak, nonatomic) IBOutlet UILabel *remindLabel;
@property (weak, nonatomic) IBOutlet UIButton *userInfoButt;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIView *userInfoView;
@property (weak, nonatomic) IBOutlet UIView *changJIngView;
@property (weak, nonatomic) IBOutlet UICollectionView *ItemCollectionView;

@property (weak, nonatomic) IBOutlet UIImageView *UserPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *UserCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *ChangJingNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ChangJingLogoImageView;
@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"会员主页";
    self.UserPhotoImageView.clipsToBounds=YES;
    self.UserPhotoImageView.layer.cornerRadius=20;
    self.UserPhotoImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    self.UserPhotoImageView.layer.borderWidth=1.0f;
    
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
    if ([USER_DEFAULT objectForKey:@"user_token"]==nil) {
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
    [ShenBaoDataRequest requestAFWithURL:@"api/xcapply_mock/usercenter" params:nil httpMethod:@"POST" block:^(id result) {
        [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        userModel=[UserCenterModel yy_modelWithDictionary:result];
        userModel.data.actions=[NSArray yy_modelArrayWithClass:[ActionsModel class] json:[[result objectForKey:@"data"] objectForKey:@"actions"]];
        userModel.data.scenes=[NSArray yy_modelArrayWithClass:[ScenesModel class] json:[[result objectForKey:@"data"] objectForKey:@"scenes"]];
        
        NSLog(@"userModel.data.userinfo.nickname====%@",userModel.data.userinfo.nickname);
        if (userModel.code==0) {
            [self configeUIData];
            [self.ItemCollectionView reloadData];
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
    [self.UserPhotoImageView sd_setImageWithURL:[NSURL URLWithString:userModel.data.userinfo.avatar] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
    self.nickNameLabel.text=[NSString stringWithFormat:@"昵称:%@",userModel.data.userinfo.nickname];
    self.UserCompanyLabel.text=[NSString stringWithFormat:@"手机号:%@",userModel.data.userinfo.tel];
    [self.ChangJingLogoImageView sd_setImageWithURL:[NSURL URLWithString:userModel.data.scene_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
    self.ChangJingNameLabel.text=userModel.data.scene_title;
    
    self.userInfoButt.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        [self performSegueWithIdentifier:@"SubmittUserInfoViewController" sender:self];
        return [RACSignal empty];
    }];
//    if ([[USER_DEFAULT objectForKey:@"status"] isEqualToString:@"login"]) {
//        self.userInfoButt.hidden=NO;
//        
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
    if ([actionModel.title isEqualToString:@"申报"]){
        if ([actionModel.name isEqualToString:@"apply_guest"]) {
          [self performSegueWithIdentifier:@"ShenBaoController" sender:self];
        }else
        {
         [self performSegueWithIdentifier:@"ZhiXingRenOrderListViewController" sender:self];
        }
    }
    else if ([actionModel.title isEqualToString:@"巡场"]) {
        [self performSegueWithIdentifier:@"XunChangController" sender:self];
    }
    else if([actionModel.title isEqualToString:@"统计"]){
        [self performSegueWithIdentifier:@"TongJiViewController" sender:self];
    }
    else if([actionModel.title isEqualToString:@"消息"]){
        [self performSegueWithIdentifier:@"MessagerViewController" sender:self];
    }
    else if([actionModel.title isEqualToString:@"巡场管理"]){
        [self performSegueWithIdentifier:@"XunChangManagerViewController" sender:self];
    }else if([actionModel.title isEqualToString:@"监管记录"]){
        [self performSegueWithIdentifier:@"JianGuanJiluViewController" sender:self];
    }
    else if([actionModel.title isEqualToString:@"整改管理"]){
        [self performSegueWithIdentifier:@"ZhenGaiViewController" sender:self];
    }
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue destinationViewController] isKindOfClass:NSClassFromString(@"ShenBaoViewController")]) {
        ShenBaoViewController *viewController=[segue destinationViewController];
        viewController.dataModel=userModel.data;
    }
    NSLog(@"sender  =%@",sender);
    NSLog(@"distinationViewcontroller=%@",NSStringFromClass([[segue destinationViewController] class]));
    
}


@end
