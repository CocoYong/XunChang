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
#define IMAGEUPLOAD @"http://kcwc.luofei.i.ubolixin.com/api/upload/index"
#define EVALUATEORDER @"api/xcapply_mock/comment"
#define USERCENTER @"api/xcapply_mock/usercenter"
#define GETMOBILEVERIFY @"api/main/getMobileVerify"
#define LOGINORREGISTER @"api/main/login"
#define BINDUSERINFO @"api/user/bindUserInfo"
#define BINDAPP @"api/api/bindApp"
#define ORDERLIST @"api/xcapply_mock/orderList"
#define STAFFORDERLIST @"api/xcapply_mock/staffOrderList"
#define ORDERDETAIL @"api/xcapply_mock/orderDetail"
#define ORDERCANCEL @"api/xcapply_mock/ordercancel"
#define ORDERDELETE @"api/xcapply_mock/orderDelete"
#define ORDERSIGN @"api/xcapply_mock/orderSign"
#define GETOBJECTMONEY @"api/xcapply_mock/getObjectMoney"
#define USEPREPAYMONEY @"api/xcapply_mock/usePrepayMoney"
#define GETOBJECT @"api/xcapply_mock/getObject"
#define CREATEORDER @"api/xcapply_mock/createOrder"
#define GETITEM @"api/xcapply_mock/getItem"
#define APPLYTYPE @"api/xcapply_mock/applyType"
#define NEWMESSAGE @"api/xcapply_mock/newMessage"
#define CLEARMESSAGE @"api/xcapply_mock/clearMessage"
#define DELETEPIC @"api/xcapply_mock/deletePic"
#define ORDERFINISH @"api/xcapply_mock/orderFinish"
#define PAYLOG @"api/xcapply_mock/payLog"

//没用到咔咔
//static inline  NSString *HomeItemsImageNamed(NSInteger itemsIndex){
//NSArray *imageArray=@[@"btn_xc",@"btn_sb",@"btn_tj",@"btn_xx",@"btn_xcgl",@"btn_jgjl",@"btn_zggl",@"btn_cksq"];
//    return [imageArray objectAtIndex:itemsIndex];
//}
//static inline NSString *orderDetailStatus(NSString *statusString){
//    NSDictionary *statusDic=@{@"pending":@"待付款",@"starting":@"付款成功",@"finish":@"等待确认",@"signin":@"交易成功"};
//    return  [statusDic objectForKey:statusString];
//}


#endif /* CommonFuncs_h */
