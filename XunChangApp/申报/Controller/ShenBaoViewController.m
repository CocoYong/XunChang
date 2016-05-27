//
//  ShenBaoViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/9.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "ShenBaoViewController.h"
#import "OrdersListViewController.h"
#import "HomeCollectionViewItemCell.h"
#import "UIImageView+WebCache.h"
#import "ShenBaoItemsModel.h"
#import "ShenBaoNewMessagesModel.h"
#import "ShenBaoLeiXingViewController.h"
@interface ShenBaoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSTimer *countTimer;
    ShenBaoItemsModel *itemModel;
    ShenBaoNewMessagesModel *newMessageModel;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *activityTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *daifukuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *daifuwuLabel;
@property (weak, nonatomic) IBOutlet UILabel *daiquerenLabel;
@property (weak, nonatomic) IBOutlet UILabel *daipingjiaLabel;

@end

@implementation ShenBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申报";
    [self createNavBackButt];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.dataModel.scene_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
    self.activityTitleLabel.text=self.dataModel.scene_title;
    
    self.daifukuanLabel.layer.cornerRadius=6.0f;
    self.daifukuanLabel.layer.masksToBounds=YES;
    self.daifuwuLabel.layer.cornerRadius=6.0f;
    self.daifuwuLabel.layer.masksToBounds=YES;
    self.daiquerenLabel.layer.cornerRadius=6.0f;
    self.daiquerenLabel.layer.masksToBounds=YES;
    self.daipingjiaLabel.layer.cornerRadius=6.0f;
    self.daipingjiaLabel.layer.masksToBounds=YES;
    
    
    countTimer=[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(countTimerRequestData) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:countTimer forMode:NSRunLoopCommonModes];
    
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"8fd4bcd74eecfcd96d8b34bba1e7644c",@"user_token",@"11",@"scene_id", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:APPLYTYPE params:paramsDic httpMethod:@"POST" block:^(id result) {
         [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        itemModel=[ShenBaoItemsModel yy_modelWithDictionary:result];
        itemModel.datas=[NSArray yy_modelArrayWithClass:[ShenBaoItemDataModel class] json:[result objectForKey:@"data"]];
        
        if (itemModel.code==0) {
            [self.collectionView reloadData];
        }else if (itemModel.code==9999)
        {
            [SVProgressHUD  showErrorWithStatus:itemModel.message maskType:SVProgressHUDMaskTypeBlack];
        }else if(itemModel.code==1001)
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
-(void)countTimerRequestData
{
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:NEWMESSAGE params:nil httpMethod:@"POST" block:^(id result) {
         [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        newMessageModel=[ShenBaoNewMessagesModel yy_modelWithDictionary:result];
        if ([[result objectForKey:@"code"] integerValue]==0) {
            if (newMessageModel.data.pending_pay_count>0) {
                self.daifukuanLabel.hidden=NO;
              self.daifukuanLabel.text=[NSString stringWithFormat:@"%d",newMessageModel.data.pending_pay_count];
            }else
            {
                self.daifukuanLabel.hidden=YES;
            }
             if (newMessageModel.data.pending_confirm_count>0) {
                 self.daiquerenLabel.hidden=NO;
                 self.daiquerenLabel.text=[NSString stringWithFormat:@"%d",newMessageModel.data.pending_confirm_count];
             }else
             {
                 self.daiquerenLabel.hidden=YES;
             }
             if (newMessageModel.data.pending_server_count>0) {
                  self.daifuwuLabel.hidden=NO;
                 self.daifuwuLabel.text=[NSString stringWithFormat:@"%d",newMessageModel.data.pending_server_count];
             }else
             {
                 self.daifuwuLabel.hidden=YES;
             }
             if (newMessageModel.data.pending_comment_count>0) {
                 self.daipingjiaLabel.hidden=NO;
                 self.daipingjiaLabel.text=[NSString stringWithFormat:@"%d",newMessageModel.data.pending_comment_count];
               }else
             {
                 self.daipingjiaLabel.hidden=YES;
             }
        }else if (newMessageModel.code==9999)
        {
            [SVProgressHUD  showErrorWithStatus:itemModel.message maskType:SVProgressHUDMaskTypeBlack];
        }else if(newMessageModel.code==1001)
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [countTimer setFireDate:[NSDate distantPast]];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return itemModel.datas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    HomeCollectionViewItemCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ShenBaoCollectionCell" forIndexPath:indexPath];
    ShenBaoItemDataModel *tempModel=[itemModel.datas objectAtIndex:indexPath.row];
    [cell.shenBaoIconImageView sd_setImageWithURL:[NSURL URLWithString:tempModel.icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
    cell.shenBaoNameLabel.text=tempModel.title;
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShenBaoItemDataModel *tempModel=[itemModel.datas objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShenBaoLeiXingViewController" sender:tempModel];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [countTimer setFireDate:[NSDate distantFuture]];
}
-(IBAction)fourButtAction:(UIButton*)sender
{
    [self performSegueWithIdentifier:@"OrdersListViewController" sender:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue destinationViewController] isKindOfClass:[OrdersListViewController class]]) {
        OrdersListViewController *viewController=[segue destinationViewController];
        UIButton *butt=sender;
        viewController.index=butt.tag;
    }
    if ([[segue destinationViewController] isKindOfClass:[ShenBaoLeiXingViewController class]]) {
        ShenBaoItemDataModel *tempModel=(ShenBaoItemDataModel*)sender;
        ShenBaoLeiXingViewController *viewController=[segue destinationViewController];
        viewController.title=tempModel.title;
        viewController.type_id=tempModel.id;
    }
}


@end
