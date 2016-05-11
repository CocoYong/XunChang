//
//  CollectionView.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/6.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionBaseModel.h"
typedef void(^ConfigeCellBlock)(id cellName,id cellModel);
typedef void(^SelectCallBack)(NSIndexPath *indexPath,id cellModel);
typedef NS_ENUM(NSInteger, ScrollDirection) {
    ScrollDirectionVertical = 0,
    ScrollDirectionHorizontal,
};
@interface GeneralCollectionView : UIView
@property(nonatomic,readonly)UICollectionView *collectionView;
-(instancetype)initWithFrame:(CGRect)frame
                 andRowItems:(NSInteger)lineItemsNum
                  andtotalItems:(NSArray*)itemsArray
           andMiniInterSpace:(CGFloat)miniInterSpace
            andMiniLineSpace:(CGFloat)miniLineSpace
          andScrollDirection:(ScrollDirection)direction
                andCellClass:(Class)className
             andConfigeBlock:(ConfigeCellBlock)configeBlock
       andSelectItemCallBack:(SelectCallBack)selectCallBack;
-(instancetype)initWithFrame:(CGRect)frame
                 itemSize:(CGSize)itemSize
               andtotalItems:(NSArray*)itemsArray
           andMiniInterSpace:(CGFloat)miniInterSpace
            andMiniLineSpace:(CGFloat)miniLineSpace
          andScrollDirection:(ScrollDirection)direction
                andCellClass:(Class)className
             andConfigeBlock:(ConfigeCellBlock)configeBlock
       andSelectItemCallBack:(SelectCallBack)selectCallBack;

@end
