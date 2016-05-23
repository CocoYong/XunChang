//
//  HomeCollectionViewItemCell.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/12.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewItemCell : UICollectionViewCell
//homeCollectionCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageNumLabel;
//shenbaoCollectionCell
@property (weak, nonatomic) IBOutlet UIImageView *shenBaoIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *shenBaoNameLabel;
//UploadServiceEvidenceCollectionCell

@end
