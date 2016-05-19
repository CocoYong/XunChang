//
//  WeiXinPayManager.h
//  XunChangApp
//
//  Created by MrZhang on 16/5/13.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import <Foundation/Foundation.h>


//回调block定义
typedef void(^PayBackBlock)(BOOL result);


@interface WeiXinPayManager : NSObject<NSXMLParserDelegate>
+(instancetype)sharedManager;
//预支付返回结果解析用到的属性
@property(nonatomic,copy)NSMutableString *contentString;
@property(nonatomic,strong)NSXMLParser *parserHelper;
@property(nonatomic,copy)NSMutableDictionary *dictionary;
/**
 *  用于服务器端已经做了预支付的情况调用以下接口
 *
 *  @param prepayID      预支付订单id
 *  @param callBackBlock 回调block
 */
-(void)payForWeiXin:(NSString*)prepayID andCallBackBlock:(PayBackBlock)callBackBlock;
/**
 *  直接填写商品参数等数据生成订单并支付
 *
 *  @param paramsDict    包含商品参数的可变字典主要key为body(商品描述+必填) detail(商品详情+非必填) attach(附加数据+非必填) total_fee(订单总金额单位为分+必填) goods_tag(商品标记+非必填)
 *  @param callBackBlock 支付结果回调
 */
-(void)payForWeixinWith:(NSMutableDictionary*)paramsDict andCallBackBlock:(PayBackBlock)callBackBlock;
@end
