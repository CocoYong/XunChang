//
//  WeiXinPayManager.m
//  XunChangApp
//
//  Created by MrZhang on 16/5/13.
//  Copyright © 2016年 zhangyong. All rights reserved.
//

#import "WeiXinPayManager.h"
#import "WXApi.h"
#import "CommonUtils.h"
#import "NSDate+ITTAdditions.h"
//getIPAddress
//#include <ifaddrs.h>
//#include <arpa/inet.h>
//#include <net/if.h>
//
//#define IOS_CELLULAR    @"pdp_ip0"
//#define IOS_WIFI        @"en0"
//#define IOS_VPN         @"utun0"
//#define IP_ADDR_IPv4    @"ipv4"
//#define IP_ADDR_IPv6    @"ipv6"

@implementation WeiXinPayManager
+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static id WeiXinPayManager;
    dispatch_once(&once, ^{
    WeiXinPayManager = [[self alloc] init];
    });
    return WeiXinPayManager;
}
#pragma mark-----客户端得到预支付订单id的情况---------
-(void)payForWeiXin:(NSString*)prepayID andCallBackBlock:(PayBackBlock)callBackBlock
{
    ITTAssert([WXApi isWXAppInstalled],@"没有安装微信");
    NSMutableDictionary  * requstPragmDict=[self paypragmasWith:prepayID];
    if (requstPragmDict==nil) {
        ITTDPRINT(@"微信支付请求参数获取失败");
    }else
    {
        PayReq *requst=[[PayReq alloc]init];
        requst.openID=[requstPragmDict objectForKey:@"appid"];
        requst.partnerId=[requstPragmDict objectForKey:@"partnerid"];
        requst.prepayId=[requstPragmDict objectForKey:@"prepayid"];
        requst.nonceStr=[requstPragmDict objectForKey:@"nonceStr"];
        requst.timeStamp=[[requstPragmDict objectForKey:@"timeStamp"] intValue];
        requst.package=[requstPragmDict objectForKey:@"package"];
        requst.sign=[requstPragmDict objectForKey:@"sign"];
        callBackBlock([WXApi sendReq:requst]);
    }
}
#pragma mark-----客户端直接由产品参数等生成预支付订单并支付的情况---------
-(void)payForWeixinWith:(NSMutableDictionary*)paramsDict andCallBackBlock:(PayBackBlock)callBackBlock
{
    NSString *prepayid=nil;
    if (paramsDict!=nil) {
        [paramsDict setObject:WEIXINAPPID forKey:@"appid"];
        [paramsDict setObject:MERCHANT_ID forKey:@"mch_id"];
        //订单号系统时间加随机序列生成
       NSString *randomString=[self md5:[NSString stringWithFormat:@"%d",arc4random()% 10]];
        ;
        [paramsDict setObject:randomString forKey:@"nonce_str"];
        NSMutableString *trade_noSting=[[NSMutableString alloc]initWithString:[[NSDate date] stringWithFormat:@"yyyyMMddHHmmss"]];
        [trade_noSting appendString:randomString];
        [paramsDict setObject:trade_noSting forKey:@"out_trade_no"];
        [paramsDict setObject:[CommonUtils getIPAddress] forKey:@"spbill_create_ip"];
        [paramsDict setObject:PHPNOTICEURL forKey:@"notify_url"];
        [paramsDict setObject:@"APP" forKey:@"trade_type"];
    }
      //需要签名参数
      NSString *codeSign=[self createMd5Sign:paramsDict];
       [paramsDict setObject:codeSign forKey:@"sign"];
    //获取提交支付xml数据
    NSString *sendString      = [self genPackage:paramsDict];
    ITTDPRINT(@"发送前的数据===%@",sendString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:PREPAYURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    //设置提交方式
    [request setHTTPMethod:@"POST"];
    //设置数据类型
    [request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    //设置编码
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    //如果是POST
    [request setHTTPBody:[sendString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error;
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    ITTDPRINT(@"发送预支付返回数据response====%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    _parserHelper=[[NSXMLParser alloc]initWithData:response];
    _parserHelper.delegate=self;
    _dictionary=[NSMutableDictionary dictionary];
    _contentString=[NSMutableString string];
    if ([_parserHelper parse]) {
        ITTDPRINT(@"解析完成返回的字典数据===%@",_dictionary);
        //判断返回
        NSString *return_code   = [_dictionary objectForKey:@"return_code"];
        NSString *result_code   = [_dictionary objectForKey:@"result_code"];
        if ( [return_code isEqualToString:@"SUCCESS"] )
        {
            //生成返回数据的签名
            NSString *sign      = [self createMd5Sign:_dictionary ];
            NSString *send_sign =[_dictionary objectForKey:@"sign"] ;
            
            //验证签名正确性
            if( [sign isEqualToString:send_sign]){
                if( [result_code isEqualToString:@"SUCCESS"]) {
                    //验证业务处理状态
                    prepayid    = [_dictionary objectForKey:@"prepay_id"];
                    return_code = 0;
                    ITTDPRINT(@"获取预支付交易标示成功！\n") ;
                    [self payForWeiXin:prepayid andCallBackBlock:callBackBlock];
                }
            }else{
                ITTDPRINT(@"gen_sign=%@\n   _sign=%@\n",sign,send_sign);
                ITTDPRINT(@"服务器返回签名验证错误！！！\n");
            }
        }else{
            ITTDPRINT(@"接口返回错误！！！\n");
        }
    }else
    {
        ITTDPRINT(@"解析出错");
    }

}
//解析文档开始
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    //NSLog(@"解析文档开始");
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    //NSLog(@"遇到启始标签:%@",elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //NSLog(@"遇到内容:%@",string);
    [_contentString setString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    //NSLog(@"遇到结束标签:%@",elementName);
    
    if( ![_contentString isEqualToString:@"\n"] && ![elementName isEqualToString:@"root"]){
        [_dictionary setObject: [_contentString copy] forKey:elementName];
        //NSLog(@"%@=%@",elementName, contentString);
    }
}

//解析文档结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    //NSLog(@"文档解析结束");
    _parserHelper=nil;
}

//获取package带参数的签名包---也就是xml数据
-(NSString *)genPackage:(NSMutableDictionary*)packageParams
{
    NSString *sign;
    NSMutableString *reqPars=[NSMutableString string];
    //生成签名
    sign        = [self createMd5Sign:packageParams];
    //生成xml的package
    NSArray *keys = [packageParams allKeys];
    [reqPars appendString:@"<xml>\n"];
    for (NSString *categoryId in keys) {
        [reqPars appendFormat:@"<%@>%@</%@>\n", categoryId, [packageParams objectForKey:categoryId],categoryId];
    }
    [reqPars appendFormat:@"<sign>%@</sign>\n</xml>", sign];
    
    return [NSString stringWithString:reqPars];
}


#pragma mark--------公用方法--------------
-(NSMutableDictionary*)paypragmasWith:(NSString*)prepayID
{
    srand( (unsigned)time(0) );
    if ( prepayID != nil) {
        //获取到prepayid后进行第二次签名
        
        NSString    *package, *time_stamp, *nonce_str;
        //设置支付参数
        time_t now;
        time(&now);
        time_stamp  = [NSString stringWithFormat:@"%ld", now];
        nonce_str	= [self md5:time_stamp];
        //重新按提交格式组包，微信客户端暂只支持package=Sign=WXPay格式，须考虑升级后支持携带package具体参数的情况
        //        package       = [NSString stringWithFormat:@"Sign=%@",package];
        package         = @"Sign=WXPay";
        //第二次签名参数列表
        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
        [signParams setObject: WEIXINAPPID        forKey:@"appid"];
        [signParams setObject: nonce_str    forKey:@"noncestr"];
        [signParams setObject: package      forKey:@"package"];
        [signParams setObject: MERCHANT_ID        forKey:@"partnerid"];
        [signParams setObject: time_stamp   forKey:@"timestamp"];
        [signParams setObject: prepayID     forKey:@"prepayid"];
        //[signParams setObject: @"MD5"       forKey:@"signType"];
        //生成签名
        NSString *sign  = [self createMd5Sign:signParams];
        //添加签名
        [signParams setObject: sign         forKey:@"sign"];
        ITTDINFO(@"第二步签名成功，sign＝%@\n",sign);
        //返回参数列表
        return signParams;
    }else{
        ITTDERROR(@"获取prepayid失败！\n");
    }
    return nil;
}
//创建package签名
-(NSString*) createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
        
    }
    //添加key字段
    [contentString appendFormat:@"key=%@", MERCHANT_PRIVAT_SECRET];
    //得到MD5 sign签名
    NSString *md5Sign =[self md5:contentString];
    
    //输出Debug Info
    ITTDPRINT(@"MD5签名字符串：\n%@\n\n",contentString);
    
    return md5Sign;
}
-(NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    return output;
}


//获取本机ip地址
//- (NSString *)getIPAddress:(BOOL)preferIPv4
//{
//    NSArray *searchArray = preferIPv4 ?
//    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
//    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
//    
//    NSDictionary *addresses = [self getIPAddresses];
//    NSLog(@"addresses: %@", addresses);
//    
//    __block NSString *address;
//    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
//     {
//         address = addresses[key];
//         if(address) *stop = YES;
//     } ];
//    return address ? address : @"0.0.0.0";
//}
//- (NSDictionary *)getIPAddresses
//{
//    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
//    
//    // retrieve the current interfaces - returns 0 on success
//    struct ifaddrs *interfaces;
//    if(!getifaddrs(&interfaces)) {
//        // Loop through linked list of interfaces
//        struct ifaddrs *interface;
//        for(interface=interfaces; interface; interface=interface->ifa_next) {
//            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
//                continue; // deeply nested code harder to read
//            }
//            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
//            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
//            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
//                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
//                NSString *type;
//                if(addr->sin_family == AF_INET) {
//                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
//                        type = IP_ADDR_IPv4;
//                    }
//                } else {
//                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
//                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
//                        type = IP_ADDR_IPv6;
//                    }
//                }
//                if(type) {
//                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
//                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
//                }
//            }
//        }
//        // Free memory
//        freeifaddrs(interfaces);
//    }
//    return [addresses count] ? addresses : nil;
//}
@end
