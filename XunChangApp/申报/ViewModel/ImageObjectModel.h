//
//  ImageObjectModel.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/19.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageObjectModel : NSObject
@property(nonatomic,strong)UIImage *originalImage;
@property(nonatomic,strong)UIImage *editImage;
@property(nonatomic,copy)NSString *originalImageName;
@property(nonatomic,copy)NSString *editImageName;
@end
