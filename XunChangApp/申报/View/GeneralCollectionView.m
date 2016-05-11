//
//  CollectionView.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/6.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "GeneralCollectionView.h"
@interface GeneralCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,readwrite)UICollectionView *collectionView;
@property(nonatomic,copy)ConfigeCellBlock configeBlock;
@property(nonatomic,copy)SelectCallBack selectCallBack;
@property(nonatomic,assign)NSInteger lineItemNum;
@property(nonatomic,copy)NSArray* itemsArray;
@property(nonatomic,assign)CGSize itemSize;
@property(nonatomic,assign) CGFloat miniInterSpace;
@property(nonatomic,assign) CGFloat miniLineSpace;
@property(nonatomic,assign) ScrollDirection direction;
@property(nonatomic,copy)Class cellClass;
@end
@implementation GeneralCollectionView
-(instancetype)initWithFrame:(CGRect)frame
                 andRowItems:(NSInteger)lineItemsNum
                  andtotalItems:(NSArray*)itemsArray
           andMiniInterSpace:(CGFloat)miniInterSpace
            andMiniLineSpace:(CGFloat)miniLineSpace
          andScrollDirection:(ScrollDirection)direction
                andCellClass:(Class)className
             andConfigeBlock:(ConfigeCellBlock)configeBlock
       andSelectItemCallBack:(SelectCallBack)selectCallBack
{
    self=[super initWithFrame:frame];
    if (!self) return nil;
    self.lineItemNum=lineItemsNum;
    self.itemsArray=itemsArray;
    self.miniLineSpace=miniLineSpace;
    self.miniInterSpace=miniInterSpace;
    self.direction=direction;
    self.cellClass=className;
    self.configeBlock=configeBlock;
    self.selectCallBack=selectCallBack;
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:className forCellWithReuseIdentifier:NSStringFromClass(className)];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
                    itemSize:(CGSize)itemSize
               andtotalItems:(NSArray*)itemsArray
           andMiniInterSpace:(CGFloat)miniInterSpace
            andMiniLineSpace:(CGFloat)miniLineSpace
          andScrollDirection:(ScrollDirection)direction
                andCellClass:(Class)className
             andConfigeBlock:(ConfigeCellBlock)configeBlock
       andSelectItemCallBack:(SelectCallBack)selectCallBack
{
    self=[super initWithFrame:frame];
    if (!self) return nil;
    self.itemsArray=itemsArray;
    self.miniLineSpace=miniLineSpace;
    self.miniInterSpace=miniInterSpace;
    self.direction=direction;
    self.cellClass=className;
    self.itemSize=itemSize;
    self.configeBlock=configeBlock;
    self.selectCallBack=selectCallBack;
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:className forCellWithReuseIdentifier:NSStringFromClass(className)];
    return self;
}
-(UICollectionView*)collectionView
{
    if (_collectionView) {
        return _collectionView;
    }
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing=self.miniInterSpace;
    flowLayout.minimumLineSpacing=self.miniLineSpace;
    if (self.lineItemNum!=0) {
        CGFloat width=(SCREEN_WIDTH-(self.lineItemNum-1)*self.miniInterSpace)/self.lineItemNum;
        flowLayout.itemSize=CGSizeMake(width, width);
    }else
    {
        flowLayout.itemSize=self.itemSize;
    }
    flowLayout.scrollDirection=self.direction==ScrollDirectionVertical?UICollectionViewScrollDirectionVertical:UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:flowLayout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor colorWithHexString:@"#e0e0e0"];
    return _collectionView;
}
#pragma mark------->>>>>>>>>>>>>UICollectionViewDataSource<<<<<<<<<<---------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemsArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.cellClass) forIndexPath:indexPath];
    id model=[self itemAtIndexPath:indexPath];
    NSLog(@"model==%@",indexPath);
    self.configeBlock(cell,model);
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemsArray[(NSUInteger)indexPath.row];
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"indexpath======%@",indexPath);
    self.selectCallBack(indexPath,[self itemAtIndexPath:indexPath]);
}
@end
