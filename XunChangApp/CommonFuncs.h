//
//  CommonFuncs.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/10.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#ifndef CommonFuncs_h
#define CommonFuncs_h
//微信开放平台注册的appid
#define WEIXINAPPID @"weixin88080432"
//微信开放平台注册的商户ID
#define MERCHANT_ID @"12312141123"
//微信开放平台注id生产的密钥
#define MERCHANT_PRIVAT_SECRET @"f82be4df226bc2cd1ac376919dd09250"

//微信预支付生成prepayid的接口--统一下单接口
#define PREPAYURL @"https://api.mch.weixin.qq.com/pay/unifiedorder"
//微信支付回调地址 php端回调地址

#define PHPNOTICEURL @""


//接口地址
#define BASICURL @"http://kcwc.luofei.i.ubolixin.com/"

static inline  NSString *HomeItemsImageNamed(NSInteger itemsIndex){
NSArray *imageArray=@[@"btn_xc",@"btn_sb",@"btn_tj",@"btn_xx",@"btn_xcgl",@"btn_jgjl",@"btn_zggl",@"btn_cksq"];
    return [imageArray objectAtIndex:itemsIndex];
}
static inline NSString *orderDetailStatus(NSString *statusString){
    NSDictionary *statusDic=@{@"pending":@"待付款",@"starting":@"付款成功",@"finish":@"等待确认",@"signin":@"交易成功"};
    return  [statusDic objectForKey:statusString];
}
#endif /* CommonFuncs_h */
