//
//  SubmittUserInfoViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/16.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "SubmittUserInfoViewController.h"
#import "ImageObjectModel.h"
#import "LoginModel.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageDownloader.h"
#import "UserCenterModel.h"
@interface SubmittUserInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    ImageObjectModel *imageModel;
    UserInfo *userinfo;
}
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButt;
@property (weak, nonatomic) IBOutlet UIButton *manButt;
@property (weak, nonatomic) IBOutlet UIButton *womanButt;
@property (weak, nonatomic) IBOutlet UIButton *submitButt;

@property(nonatomic,copy)NSString *sex;
@end

@implementation SubmittUserInfoViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self createNavBackButt];
    self.title=@"基本资料";
    self.submitButt.layer.cornerRadius=4.0f;
    imageModel=[[ImageObjectModel alloc]init];
    imageModel.data=[[ImageObjectDataModel alloc]init];
    userinfo=[UserInfo yy_modelWithDictionary:[USER_DEFAULT objectForKey:@"userinfo"]];//字典转为数组..
    [self.manButt setImage:[UIImage imageNamed:@"radio_normal"] forState:UIControlStateNormal];
    [self.womanButt setImage:[UIImage imageNamed:@"radio_normal"] forState:UIControlStateNormal];
    if (userinfo.avatar!=nil&&![userinfo.avatar isEqualToString:@""]) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:userinfo.avatar] options:SDWebImageDownloaderProgressiveDownload progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
        [self.addPhotoButt setImage:image forState:UIControlStateNormal];
            });
            imageModel.originalImage=image;
            imageModel.originalImageName=[NSString stringWithFormat:@"%@_original.png",[[NSDate date] stringWithFormat:@"yyyy-MM-dd_HHmmss"]];
        }];
    }
    if (userinfo.nickname!=nil) {
        self.nickNameTextField.text=userinfo.nickname;
    }
    if ([userinfo.sex isEqualToString:@"MAN"]) {
        self.manButt.selected=YES;
        [self.manButt setImage:[UIImage imageNamed:@"radio_selected"] forState:UIControlStateNormal];
        self.sex=userinfo.sex;
    }else if ([userinfo.sex isEqualToString:@"WOMAN"])
    {
        self.womanButt.selected=YES;
        [self.womanButt setImage:[UIImage imageNamed:@"radio_selected"] forState:UIControlStateNormal];
        self.sex=userinfo.sex;
    }else
    {
        self.manButt.selected=NO;
        self.womanButt.selected=NO;
        self.sex=userinfo.sex;
    }
    if (![[USER_DEFAULT objectForKey:@"status"] isEqualToString:@"register"]) {
        self.manButt.enabled=NO;
        self.womanButt.enabled=NO;
    }
}
-(void)backToFrontViewController
{
    [USER_DEFAULT setObject:@"login" forKey:@"status"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)manButtAction:(UIButton *)sender {
    sender.selected=!sender.selected;
    if (sender.selected) {
    [self.manButt setImage:[UIImage imageNamed:@"radio_selected"] forState:UIControlStateNormal];
      self.sex=@"MAN";
        if (self.womanButt.selected) {
            self.womanButt.selected=NO;
            [self.womanButt setImage:[UIImage imageNamed:@"radio_normal"] forState:UIControlStateNormal];
        }
    }else
    {
        [self.manButt setImage:[UIImage imageNamed:@"radio_normal"] forState:UIControlStateNormal];
        if (!self.womanButt.selected) {
            self.sex=@"SECRECY";
        }
    }
}
- (IBAction)womanButtAction:(UIButton *)sender {
    sender.selected=!sender.selected;
    if (sender.selected) {
        self.sex=@"WOMAN";
        [self.womanButt setImage:[UIImage imageNamed:@"radio_selected"] forState:UIControlStateNormal];
        if (self.manButt.selected) {
            self.manButt.selected=NO;
             [self.manButt setImage:[UIImage imageNamed:@"radio_normal"] forState:UIControlStateNormal];
        }
    }else
    {
        [self.womanButt setImage:[UIImage imageNamed:@"radio_normal"] forState:UIControlStateNormal];
        if (!self.manButt.selected) {
          self.sex=@"SECRECY";
        }
    }
}
//选择图片
- (IBAction)addPhotoButtAction:(UIButton *)sender {
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:imagePicker.sourceType];
    }
    imagePicker.delegate=self;
    imagePicker.allowsEditing=YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        imageModel.originalImage=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        imageModel.editImage=[info objectForKey:@"UIImagePickerControllerEditedImage"];
        imageModel.originalImageName=[NSString stringWithFormat:@"%@_original.png",[[NSDate date] stringWithFormat:@"yyyy-MM-dd_HHmmss"]];
        imageModel.editImageName=[NSString stringWithFormat:@"%@_editing.png",[[NSDate date] stringWithFormat:@"yyyy-MM-dd_HHmmss"]];
    }
    [self.addPhotoButt setImage:imageModel.originalImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)submittUserInfoAction:(UIButton *)sender {
    
    if ([self.nickNameTextField.text isEqualToString:@""]||self.nickNameTextField.text==nil) {
        [SVProgressHUD showErrorWithStatus:@"昵称没填呢.." maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    if (imageModel.originalImage==nil) {
        [SVProgressHUD showErrorWithStatus:@"图像没选呢.." maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.sex,@"sex",self.nickNameTextField.text,@"nickname", nil];
    [SVProgressHUD showWithStatus:@"正在上传数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestUpLoadImageurl:BINDUSERINFO params:paramsDic httpMethod:@"POST" imageData:imageModel.originalImage fileName:imageModel.originalImageName iamgeUrlParams:@"avatar" successCallBackBlock:^(id result) {
         [SVProgressHUD dismiss];
        LoginModel *model=[LoginModel yy_modelWithJSON:result];
        if (model.code==0) {
            [SVProgressHUD showSuccessWithStatus:@"更新资料成功" maskType:SVProgressHUDMaskTypeBlack];
            [self backToFrontViewController];
        }else if(model.code==9999)
        {
            [SVProgressHUD  showErrorWithStatus:model.message maskType:SVProgressHUDMaskTypeBlack];
        }else if(imageModel.code==1001)
        {
            [USER_DEFAULT removeObjectForKey:@"user_token"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } errorBlock:^(NSError *error) {
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
        [SVProgressHUD  showErrorWithStatus:@"网络请求错误了..." maskType:SVProgressHUDMaskTypeBlack];
    } noNetworkingBlock:^(NSString *noNetWorking) {
        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"icon_cry"]];
        [SVProgressHUD  showErrorWithStatus:@"没网了..." maskType:SVProgressHUDMaskTypeBlack];
    }];
}
- (IBAction)risignKeyboard:(id)sender {
    [self.view endEditing:YES];
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
