//
//  UpLoadServiceEvidenceViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/18.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "UpLoadServiceEvidenceViewController.h"
#import "UIPlaceHolderTextView.h"
#import "UploadServiceEvidenceCollectionCell.h"
#import "LoginModel.h"
@interface UpLoadServiceEvidenceViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *placeHolderView;

@end

@implementation UpLoadServiceEvidenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"完成服务凭证";
    [self createNavBackButt];
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.placeHolderView.text,@"service_message",self.orderNum,@"order_num", nil];
    [ShenBaoDataRequest requestUpLoadImageurl:@"api/xcapply_mock/orderFinish" params:paramsDic httpMethod:@"POST" imageData:[UIImage imageNamed:@"icon_cpmrt"] fileName:@"icon_cpmrt" iamgeUrlParams:@"service_pic" successCallBackBlock:^(id result) {
        NSLog(@"result====%@",result);
        LoginModel *model=[LoginModel yy_modelWithDictionary:result];
        if (model.code==0) {
            [SVProgressHUD showWithStatus:@"上传成功"];
        }else
        {
            [SVProgressHUD showErrorWithStatus:model.message maskType:SVProgressHUDMaskTypeClear];
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"error====%@",error);
    } noNetworkingBlock:^(NSString *noNetWorking) {
        
    }];

}
- (IBAction)takePhotoButtAction:(UIButton *)sender {
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 15;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UploadServiceEvidenceCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"UploadServiceEvidenceCollectionCell" forIndexPath:indexPath];

    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-30)/2, 81);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   


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
