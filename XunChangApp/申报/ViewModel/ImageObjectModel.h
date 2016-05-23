//
//  ImageObjectModel.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/19.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ImageObjectDataModel,ImageObjectDataSourceModel;
@interface ImageObjectModel : NSObject
@property(nonatomic,assign)NSInteger code;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong) ImageObjectDataModel *data;
@property(nonatomic,strong)UIImage *originalImage;
@property(nonatomic,strong)UIImage *editImage;
@property(nonatomic,copy)NSString *originalImageName;
@property(nonatomic,copy)NSString *editImageName;
@end

@interface ImageObjectDataModel : NSObject
@property(nonatomic,strong)ImageObjectDataSourceModel *source;
@property(nonatomic,copy)NSString *savename;
@property(nonatomic,copy)NSString *url;
@end

@interface ImageObjectDataSourceModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *size;
@property(nonatomic,copy)NSString *key;
@property(nonatomic,copy)NSString *ext;
@property(nonatomic,copy)NSString *md5;
@property(nonatomic,copy)NSString *sha1;
@property(nonatomic,copy)NSString *savename;
@property(nonatomic,copy)NSString *savepath;
@end