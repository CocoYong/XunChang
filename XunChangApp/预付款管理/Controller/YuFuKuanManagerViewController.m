//
//  YuFuKuanManagerViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/23.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "YuFuKuanManagerViewController.h"
#import "ShenBaoLeiXingCell.h"
#import "YuFuKuanModel.h"
#import "UIImageView+WebCache.h"
#import "MoneyModel.h"
#import "RadiumListViewController.h"
@interface YuFuKuanManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    YuFuKuanModel *yuFuKuanModel;
    MoneyModel *moneyModel;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YuFuKuanManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"预付款管理";
    [self createNavBackButt];
    self.tableView.tableFooterView=[UIView new];
    [self requestDataSource:nil];
}

-(void)requestDataSource:(NSString*)object_id
{
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"prepay",@"type",object_id==nil?@"":object_id,@"object_id", nil];
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    [ShenBaoDataRequest requestAFWithURL:PAYLOG params:paramsDic httpMethod:@"POST" block:^(id result) {
        [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
        if ([[result objectForKey:@"code"]integerValue]==0) {
            yuFuKuanModel=[YuFuKuanModel yy_modelWithDictionary:result];
            yuFuKuanModel.data.listsArray=[NSArray yy_modelArrayWithClass:[YuFuKuanDataListsModel class] json:[[result objectForKey:@"data"] objectForKey:@"lists"]];
            yuFuKuanModel.data.objectsArray=[NSArray yy_modelArrayWithClass:[YuFuKuanDataObjectsModel class] json:[[result objectForKey:@"data"] objectForKey:@"objects"]];
            [self.tableView reloadData];
        }else if ([[result objectForKey:@"code"]integerValue]==9999)
        {
            [SVProgressHUD  showErrorWithStatus:yuFuKuanModel.message maskType:SVProgressHUDMaskTypeBlack];
        }else if([[result objectForKey:@"code"]integerValue]==1001)
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else
    {
        return yuFuKuanModel.data.listsArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0&&indexPath.section==0) {
      ShenBaoLeiXingCell *cellOne=[tableView dequeueReusableCellWithIdentifier:@"YuFuKuanCellOne"];
        [cellOne.yuFuKuanRadiumImageView sd_setImageWithURL:[NSURL URLWithString:yuFuKuanModel.data.object_icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
        cellOne.yuFuKuanRadiumNameLabel.text=yuFuKuanModel.data.object_title;
        cellOne.moneyLabel.text=[NSString stringWithFormat:@"￥%@", [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:[yuFuKuanModel.data.money floatValue]] numberStyle:NSNumberFormatterDecimalStyle]];
        cellOne.useMoneyLabel.text=[NSString stringWithFormat:@"￥%@", [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:[yuFuKuanModel.data.paid_money floatValue]] numberStyle:NSNumberFormatterDecimalStyle]];
        [cellOne.yuFuKuanButt addTarget:self action:@selector(selectChangGuanButtAction) forControlEvents:UIControlEventTouchUpInside];
        if (yuFuKuanModel.data.objectsArray.count<=1) {
            cellOne.yuFuKuanButt.hidden=YES;
        }else
        {
            cellOne.yuFuKuanButt.hidden=NO;
        }
        return cellOne;
    }else
    {
       ShenBaoLeiXingCell *cellTwo=[tableView dequeueReusableCellWithIdentifier:@"YuFuKuanCellTwo"];
        YuFuKuanDataListsModel *tempDataModel=[yuFuKuanModel.data.listsArray objectAtIndex:indexPath.row];
        cellTwo.yuFuKuanTitleLabel.text=tempDataModel.realname;
        [cellTwo.yuFuKuanObjectImageView sd_setImageWithURL:[NSURL URLWithString:tempDataModel.icon] placeholderImage:[UIImage imageNamed:@"icon_cpmrt"] options:SDWebImageProgressiveDownload];
        cellTwo.useMoneyDetailLabel.text=tempDataModel.title;
        cellTwo.yuFuKuanTimeLabel.text=tempDataModel.create_time;
        if ([tempDataModel.money hasPrefix:@"+"]) {
            cellTwo.moneyNumLabel.textColor=[UIColor colorWithHexString:@"#D26A2B"];
        }else
        {
            cellTwo.moneyNumLabel.textColor=[UIColor blackColor];
        }
        cellTwo.moneyNumLabel.text=[NSString stringWithFormat:@"￥%@", [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:[tempDataModel.money floatValue]] numberStyle:NSNumberFormatterDecimalStyle]];
        return cellTwo;
    }
 }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return 102;
    }else
    {
        return 81;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else
    {
        return 40;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {

    UIView *sectionHeader=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    sectionHeader.backgroundColor=[UIColor colorWithHexString:@"#EFF0F1"];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH, 20)];
    label.text=@"交易流水";
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=[UIColor darkGrayColor];
    label.textAlignment=NSTextAlignmentLeft;
    [sectionHeader addSubview:label];
    return sectionHeader;
    }else
    {
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0&&yuFuKuanModel.data.objectsArray.count>1) {
       [self performSegueWithIdentifier:@"RadiumListViewController" sender:self];
    }
}
-(void)selectChangGuanButtAction
{
    [self performSegueWithIdentifier:@"RadiumListViewController" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RadiumListViewController *radiumController=[segue destinationViewController];
    radiumController.objectsArray=yuFuKuanModel.data.objectsArray;
    radiumController.objectCallBlock=^(YuFuKuanDataObjectsModel *objectModel){
        [self requestDataSource:objectModel.id];
    };
}


@end
