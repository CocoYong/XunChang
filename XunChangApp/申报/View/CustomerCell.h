//
//  CustomerCell.h
//  TestProject
//
//  Created by MrZhang on 16/1/3.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CustomerCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *backImageView;
@property(nonatomic,strong)UILabel *bigTitleLabel;
@property(nonatomic,strong)UILabel *smallTitleLabel;
-(instancetype)initWithFrame:(CGRect)frame;
@end
