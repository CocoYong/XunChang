//
//  ShenBaoOrdersCommitViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/10.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "ShenBaoOrdersCommitViewController.h"
#import "ShenBaoOrdersCommitCell.h"
#import "NSDate+ITTAdditions.h"
#import "PayViewController.h"
#import "CreateOrderModel.h"
@interface ShenBaoOrdersCommitViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UITextFieldDelegate>
{
    NSMutableArray *dataArray;
}

@property(nonatomic,strong)UIDatePicker *datePickView;
@property(nonatomic,copy)NSString *datePickType;
@property(nonatomic,strong)NSDate *startDate;
@property(nonatomic,strong)NSDate *endDate;
@end

@implementation ShenBaoOrdersCommitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"提交申报订单";
    [self createNavBackButt];
    if ([self.itemObjectModel.count_type isEqualToString:@"2"]) {
        self.dataModel.hasSquare=YES;
        self.dataModel.squareNum=self.objectModel.square;
        self.dataModel.feiyong_money=[NSString stringWithFormat:@"￥%.2f",[self.dataModel.price floatValue]*self.dataModel.squareNum];
        self.dataModel.yajin_money=[NSString stringWithFormat:@"￥%.2f",[self.dataModel.deposit_money floatValue]];
        self.dataModel.total_money=[NSString stringWithFormat:@"￥%.2f",[self.dataModel.price floatValue]*self.dataModel.squareNum+[self.dataModel.deposit_money floatValue]];
    }else
    {
        self.dataModel.feiyong_money=[NSString stringWithFormat:@"￥%.2f",[self.dataModel.price floatValue]];
        self.dataModel.yajin_money=[NSString stringWithFormat:@"￥%.2f",[self.dataModel.deposit_money floatValue]];
        self.dataModel.total_money=[NSString stringWithFormat:@"￥%.2f",[self.dataModel.price floatValue]+[self.dataModel.deposit_money floatValue]];
        self.dataModel.hasSquare=NO;
    }
    self.dataModel.object_num=@"1";
    dataArray=[NSMutableArray array];

}
- (IBAction)addShenBaoAction:(UIButton *)sender {
    
    ShenBaoOrdersCommitCell *cellThree=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    ShenBaoOrdersCommitCell *cellTwo=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if ([cellThree.startTimeTextField.text isEqualToString:@""]||cellThree.startTimeTextField.text==nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择开始使用时间" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    if ([cellThree.endTimeTextField.text isEqualToString:@""]||cellThree.endTimeTextField.text==nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择结束使用时间" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    if ([self.startDate compare:self.endDate]==NSOrderedDescending||[self.startDate compare:self.endDate]==NSOrderedSame) {
        [SVProgressHUD showErrorWithStatus:@"结束使用时间不能早于或等于开始使用时间" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.objectModel.id,@"object_id",self.dataModel.id,@"item_id",cellTwo.numLabel.text,@"num",cellThree.startTimeTextField.text,@"start_time",cellThree.endTimeTextField.text,@"end_time", nil];
    [ShenBaoDataRequest requestAFWithURL:CREATEORDER params:paramsDic httpMethod:@"POST" block:^(id result) {
         [SVProgressHUD dismiss];
        NSLog(@"result====%@",result);
         CreateOrderModel*resultModel=[CreateOrderModel yy_modelWithDictionary:result];
        if (resultModel.code==0) {
            self.dataModel.object_num=cellTwo.numLabel.text;
            self.dataModel.order_num=resultModel.data.order_num;
            [dataArray addObject:self.dataModel];
            [self performSegueWithIdentifier:@"PayViewController" sender:self];
        }else if (resultModel.code==9999)
        {
           [SVProgressHUD  showErrorWithStatus:resultModel.message maskType:SVProgressHUDMaskTypeBlack];
        }else if(resultModel.code==1001)
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
    if (section==0||section==1) {
        return 5;
    }else
    {
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
     ShenBaoOrdersCommitCell *cellOne=[tableView dequeueReusableCellWithIdentifier:@"ShenBaoOrdersCommitCelleight"];
        if (indexPath.row==0) {
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 1)];
            lineView.backgroundColor=[UIColor colorWithHexString:@"#B5B6B7"];
            [cellOne addSubview:lineView];
         cellOne.itemTitleLabel.text=@"科目";
         cellOne.itemDetailLabel.text=self.dataModel.order_title;
        }else if (indexPath.row==1)
        {
            cellOne.itemTitleLabel.text=@"单位";
            cellOne.itemDetailLabel.text=self.dataModel.unit;
        }else if (indexPath.row==2)
        {
            cellOne.itemTitleLabel.text=@"单价";
            cellOne.itemDetailLabel.text=[NSString stringWithFormat:@"￥%.2f",[self.dataModel.price floatValue]];
        }else if (indexPath.row==3)
        {
            cellOne.itemTitleLabel.text=@"押金";
            cellOne.itemDetailLabel.text=[NSString stringWithFormat:@"￥%.2f",[self.dataModel.deposit_money floatValue]];
        }else
        {
            if (self.dataModel.intro==nil||[self.dataModel.intro isEqualToString:@""]) {
                cellOne.hidden=YES;
            }else
            {
                cellOne.hidden=NO;
                cellOne.itemTitleLabel.text=@"说明";
                cellOne.itemDetailLabel.text=self.dataModel.intro;
            }
        }
        return cellOne;
    }else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            ShenBaoOrdersCommitCell *cellTwo=[tableView dequeueReusableCellWithIdentifier:@"ShenBaoOrdersCommitCellTwo"];
            cellTwo.dataModel=self.dataModel;
            cellTwo.superController=self;
            cellTwo.numLabel.text=self.dataModel.object_num;
            return cellTwo;
        }else
        {
            ShenBaoOrdersCommitCell *sectionTwoCell=[tableView dequeueReusableCellWithIdentifier:@"ShenBaoOrdersCommitCellThree"];
            if (indexPath.row==1) {
                sectionTwoCell.mainTextLabel.text=@"使用面积";
                sectionTwoCell.moneyLabel.text=[NSString stringWithFormat:@"%.2f㎡",self.dataModel.squareNum];
            if ([self.itemObjectModel.count_type isEqualToString:@"1"]) {
                   sectionTwoCell.hidden=YES;
                }else
                {
                   sectionTwoCell.hidden=NO;
                }
            }else if (indexPath.row==2)
            {
                sectionTwoCell.mainTextLabel.text=@"费用金额";
                sectionTwoCell.moneyLabel.text=self.dataModel.feiyong_money;
            }else if (indexPath.row==3)
            {
                sectionTwoCell.mainTextLabel.text=@"押金金额";
                sectionTwoCell.moneyLabel.text=self.dataModel.yajin_money;
            }else
            {
                sectionTwoCell.mainTextLabel.text=@"合计";
                sectionTwoCell.moneyLabel.textColor=[UIColor colorWithHexString:@"#E4271B"];
                sectionTwoCell.moneyLabel.text=self.dataModel.total_money;
            }
            return sectionTwoCell;
        }
    }else
    {
        ShenBaoOrdersCommitCell *cellThree=[tableView dequeueReusableCellWithIdentifier:@"ShenBaoOrdersCommitCellFive"];
        [cellThree.startTimeButt addTarget:self action:@selector(startTimeButtAction:) forControlEvents:UIControlEventTouchUpInside];
        [cellThree.endTimeButt addTarget:self action:@selector(endTimeButtAction:) forControlEvents:UIControlEventTouchUpInside];
        cellThree.startTimeTextField.delegate=self;
        cellThree.startTimeTextField.tag=100;
        cellThree.endTimeTextField.tag=200;
        cellThree.endTimeTextField.delegate=self;
        return cellThree;
    }
}
-(void)startDoSomething
{
    [self.view endEditing:YES];
    
    NSLog(@"do something");
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row<4) {
            return 44;
        }else
        {
            if (self.dataModel.intro==nil||[self.dataModel.intro isEqualToString:@""]) {
                return 0;
            }else
            {
            CGRect calculatRect=[self.dataModel.intro boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-120, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
                 return calculatRect.size.height+22;
            }
        }
    }else if(indexPath.section==1)
    {
        if (indexPath.row==0) {
            return 44;
        }else if (indexPath.row==1)
        {
            if ([self.itemObjectModel.count_type isEqualToString:@"1"]) {
                return 0;
            }
            return 30;
        }else if (indexPath.row==2)
        {
            return 30;
        }else
        {
            return 30;
        }
    }else
    {
        return 102;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0||section==1) {
        return 10;
    }else
    {
        return 0;
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    if (textField.tag==100) {
        self.datePickType=@"start";
        [self createDatePickerView:self.endDate];
    }else
    {
        self.datePickType=@"end";
        [self createDatePickerView:self.startDate];
    }
//    [self.view endEditing:YES];
    return NO;
}
-(void)startTimeButtAction:(UIButton*)startButt
{
    self.datePickType=@"start";
    [self createDatePickerView:self.endDate];
}
-(void)endTimeButtAction:(UIButton*)endButt
{
    self.datePickType=@"end";
    [self createDatePickerView:self.startDate];
}
#pragma mark-------日期选择---------
-(void)createDatePickerView:(NSDate*)selctDate
{
    if (IOS8_OR_LATER) {
        UIAlertController*alertController=[UIAlertController alertControllerWithTitle:
                                           @"" message:@"\n\n\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
        _datePickView=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 5, CGRectGetWidth(alertController.view.frame)-20, 162)];
        [_datePickView setValue:[NSValue valueWithCGRect:CGRectMake(0, 9, SCREEN_WIDTH-20, 216)] forKey:@"frame"];
        _datePickView.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        _datePickView.calendar=[NSCalendar currentCalendar];
        _datePickView.timeZone=[[NSTimeZone alloc]initWithName:@"Asia//Beijing"];
        _datePickView.backgroundColor=[UIColor colorWithRed:241/255.f green:241/255.f blue:241/255.f alpha:1];
        if ([self.datePickType isEqualToString:@"start"]) {
            if (self.endDate!=nil) {
                _datePickView.maximumDate=self.endDate;
            }else
            {
                _datePickView.minimumDate=[NSDate date];
            }
        }else
        {
            if (self.startDate!=nil) {
                _datePickView.minimumDate=self.startDate;
            }else
            {
                _datePickView.minimumDate=[NSDate date];
            }
        }
       
        [alertController.view addSubview:_datePickView];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self pickerDateAction:_datePickView];
        }]];
        [self presentViewController:alertController animated:YES completion:^{
            NSLog(@"完事了不出事。。。。。。");
        }];
    }else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n"
                                                                 delegate:self
                                                        cancelButtonTitle:@"取  消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"确  定", nil];
        actionSheet.tag=100;
        [actionSheet showInView:self.view];
        _datePickView=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 5, CGRectGetWidth(actionSheet.frame)-20, 162)];
        [_datePickView setValue:[NSValue valueWithCGRect:CGRectMake(10, 7, SCREEN_WIDTH-20, 216)] forKey:@"frame"];
        _datePickView.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        _datePickView.calendar=[NSCalendar currentCalendar];
        _datePickView.timeZone=[[NSTimeZone alloc]initWithName:@"Asia//Beijing"];
        _datePickView.backgroundColor=[UIColor colorWithRed:241/255.f green:241/255.f blue:241/255.f alpha:1];
        if ([self.datePickType isEqualToString:@"start"]) {
            if (self.endDate!=nil) {
                _datePickView.maximumDate=self.endDate;
            }else
            {
                _datePickView.minimumDate=[NSDate date];
            }
        }else
        {
            if (self.startDate!=nil) {
                _datePickView.minimumDate=self.startDate;
            }else
            {
                _datePickView.minimumDate=[NSDate date];
            }
        }
        [actionSheet addSubview:_datePickView];
    }
}
-(void)pickerDateAction:(UIDatePicker*)datePicker
{
    ShenBaoOrdersCommitCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    if ([self.datePickType isEqualToString:@"start"]) {
        self.startDate=datePicker.date;
        cell.startTimeTextField.text=[datePicker.date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else
    {
        if ([datePicker.date compare:[NSDate date]]==NSOrderedSame) {
            [SVProgressHUD showErrorWithStatus:@"结束日期不可以选择现在" maskType:SVProgressHUDMaskTypeClear];
            return;
        }
         self.endDate=datePicker.date;
        cell.endTimeTextField.text=[datePicker.date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    PayViewController *payController=[segue destinationViewController];
    payController.dataArray=[dataArray copy];
    payController.object_id=self.objectModel.id;
}


@end
