//
//  HomeViewController.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/6.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "HomeViewController.h"
#import "CollectionBaseModel.h"
#import "CustomerCell.h"
#import "GeneralCollectionView.h"
@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *UserPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *UserCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *ChangJingNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ChangJingLogoImageView;

@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"会员主页";
    NSMutableArray *itemArraay=[NSMutableArray arrayWithCapacity:15];
    for (int i=0; i<8; i++) {
        CollectionBaseModel * model=[[CollectionBaseModel alloc]init];
        model.itemID=i;
        model.imageName=@"wang";
        model.titleName=@"xiao";
        [itemArraay addObject:model];
    }
    GeneralCollectionView *collectionView=[[GeneralCollectionView alloc]initWithFrame:CGRectMake(0, 128, SCREEN_WIDTH, SCREEN_WIDTH/2) andRowItems:4 andtotalItems:itemArraay andMiniInterSpace:1 andMiniLineSpace:1 andScrollDirection:ScrollDirectionVertical andCellClass:[CustomerCell class] andConfigeBlock:^(id cellName, id cellModel) {
        CustomerCell *testCell=(CustomerCell*)cellName;
        CollectionBaseModel *testModel=(CollectionBaseModel*)cellModel;
        testCell.bigTitleLabel.text=testModel.imageName;
        testCell.smallTitleLabel.text=testModel.titleName;
        
    } andSelectItemCallBack:^(NSIndexPath *indexPath, id cellModel) {
        
    }];
    [self.view addSubview:collectionView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavBarColor:[UIColor colorWithHexString:@"#f8f8f8"]];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]};
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"distinationViewcontroller=%@",NSStringFromClass([[segue destinationViewController] class]));
    
}


@end
