//
//  Manager.h
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/7.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

//首先导入头文件信息
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

NS_ASSUME_NONNULL_BEGIN

@interface Manager : NSObject
+ (Manager *)sharedManager;

//获取字符串的宽度
+(float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height;
//获得字符串的高度
+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

//存
+ (void)writewenjianming:(NSString *)wenjianming content:(NSString *)content;
//取
+ (NSString *)redingwenjianming:(NSString *)wenjianming;
//删除
+ (void)remove:(NSString *)paths;
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;
//判断对象
+ (BOOL)judgeWhetherIsEmptyAnyObject:(id)object;


//时间戳转时间
+ (NSString *)TimeCuoToTime:(NSString *)str;
+ (NSString *)TimeCuoToTimes:(NSString *)str;
//获取IP地址
- (NSString *)getIPAddress:(BOOL)preferIPv4;
//日期相减
+ (NSInteger)calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;

//处理返回的数据类型
+ (NSDictionary *)returndictiondata:(NSData *)responseObject;
+ (void)requestPOSTWithURLStr:(NSString *)urlStr
                     paramDic:(NSDictionary *)paramDic
                       finish:(void(^)(id responseObject))finish
                      enError:(void(^)(NSError *error))enError;
@end

NS_ASSUME_NONNULL_END
