//
//  XML.m
//  QuickPos
//
//  Created by 糊涂 on 15/3/18.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "XML.h"
#import "DDXML.h"
#include "ifaddrs.h"
#include <arpa/inet.h>
#import <UIKit/UIKit.h>
#define APPUSER1             @"bmznxh"

#define SIGN1                @"1sml1e49mdq3m6l8bci5rm0ffjekfjg3"
@implementation XML

// 解析报文
- (NSDictionary*)deXMLWithData:(NSData*)data {
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [self deXMLWithString:str];
}
// 解析报文
- (NSDictionary*)deXMLWithString:(NSString*)string {
    NSError *err;
    DDXMLElement *xml = [[DDXMLElement alloc] initWithXMLString:string error:&err];
    
    return [self deXMLWithElement:xml];
}
// 解析报文
- (NSDictionary *)deXMLWithElement:(DDXMLElement *)element{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSArray *att = [element attributes];
    for (DDXMLNode*item in att) {
        [dict setObject:[item stringValue] forKey:[item name]];
    }
    
    NSArray *child = [element children];
    for (DDXMLNode *item in child){
        
        NSArray *arr = [element elementsForName:[item name]];
        if ([arr count] > 1) {
            NSMutableArray *ma = [[NSMutableArray alloc] initWithCapacity:[arr count]];
            for (DDXMLElement* ele in arr) {
                [ma addObject:[self deXMLWithElement:ele]];
            }
            [dict setObject:ma forKey:[item name]];
        }else{
            NSError *err;
            NSData *tojson = [[item stringValue] dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:tojson options:NSJSONReadingMutableContainers error:&err];
            if (err) {
                [dict setObject:[item stringValue] forKey:[item name]];
            }else if(json){
                [dict setObject:json forKey:[item name]];
            }
        }
    }
   
    NSString *transLogNo = [NSString stringWithFormat:@"%06d",[[dict objectForKey:@"transLogNo"] integerValue] +1];
    if (transLogNo) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:transLogNo forKey:@"transLogNo"];
        [user synchronize];
    }
    
    return (NSDictionary*)dict;
}

// 请求数据报文格式话
- (NSString*)xmlDataWithDict:(NSDictionary*)dic{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //根结点
    DDXMLElement *root = [[DDXMLElement alloc] initWithName:@"QtPay"];
    // appuser
    DDXMLNode *nAppUser = [DDXMLNode attributeWithName:@"appUser" stringValue:APPUSER1];
    [root addAttribute:nAppUser];
    //版本号
    NSString *strVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] ;
//    NSString *strVersion = @"2.0.6";
    
    DDXMLNode *nVersion = [DDXMLNode attributeWithName:@"version" stringValue:strVersion];
    [root addAttribute:nVersion];
    //系统版本
    NSString *strSysVersion = [NSString stringWithFormat:@"iOS%@", [[UIDevice currentDevice] systemVersion]];
    DDXMLNode *nSysVersion = [DDXMLNode attributeWithName:@"osType" stringValue:strSysVersion];
    [root addAttribute:nSysVersion];
    // 设备标识uuid
    
    DDXMLNode *nUUID = [DDXMLNode attributeWithName:@"mobileSerialNum" stringValue:[self getUUID]];
    [root addAttribute:nUUID];
    // IP地址
    
    DDXMLNode *nAddress = [DDXMLNode attributeWithName:@"userIP" stringValue:[self getAddreass]];
    [root addAttribute:nAddress];
    // 客户端类型
    DDXMLNode *nClientType = [DDXMLNode attributeWithName:@"clientType" stringValue:@"01"];
    [root addAttribute:nClientType];
    // phone
    NSString *strPhone = [user objectForKey:@"mobileNo"];
    if (!strPhone) {
        strPhone = [dic objectForKey:@"mobileNo"];
    }
    if (!strPhone) {
        strPhone = @"";
    }
    
    if ([[dic objectForKey:@"application"] isEqualToString:@"QuickBankCardConfirm"]) {
        strPhone = [[NSUserDefaults standardUserDefaults]  objectForKey: @"mobileNo"];
    }
    
   strPhone = [self returnStrPhone:dic string:strPhone];
    DDXMLNode *nPhone = [DDXMLNode attributeWithName:@"phone" stringValue:strPhone];
    [root addAttribute:nPhone];
    // 流水号
    NSInteger log = [[user objectForKey:@"transLogNo"] integerValue];//流水号请求时自增
    NSString *strLog = [NSString stringWithFormat:@"%06ld",(long)log];
    DDXMLNode *nTransLog = [DDXMLNode elementWithName:@"transLogNo" stringValue:strLog];
    [root addChild:nTransLog];
    // 流水时间
    
    NSArray *arrDate = [self getCurrentTime];
    DDXMLNode *nTransData = [DDXMLNode elementWithName:@"transDate" stringValue:[arrDate objectAtIndex:0]];
    [root addChild:nTransData];
    
    DDXMLNode *nTransTime = [DDXMLNode elementWithName:@"transTime" stringValue:[arrDate objectAtIndex:1]];
    [root addChild:nTransTime];
    // sign
    DDXMLNode *nSign = [DDXMLNode elementWithName:@"sign" stringValue:SIGN1];
    [root addChild:nSign];
    
    for (NSString*key in [dic allKeys]) {
        if ([@"token" isEqualToString:key]) {
            // Token
            DDXMLNode *nToken = [DDXMLNode attributeWithName:@"token" stringValue:[dic objectForKey:@"token"]];
            [root addAttribute:nToken];
        } else if ([@"application" isEqualToString:key]){
            //功能
            NSString *strApplication = [NSString stringWithFormat:@"%@.Req", [dic objectForKey:@"application"]];
            DDXMLNode *nApplication = [DDXMLNode attributeWithName:@"application" stringValue:strApplication];
            [root addAttribute:nApplication];
        } else {
            DDXMLNode *item = [DDXMLNode elementWithName:key stringValue:[dic objectForKey:key]];
            [root addChild:item];
        }
    }
    return [root XMLString];
}

// 获取当前时间
- (NSArray*)getCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMdd-HHmmss"];
    format.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSString*strDate = [format stringFromDate:date];
    return [strDate componentsSeparatedByString:@"-"];
}
// 获取本地IP地址
- (NSString *)getAddreass{
    
    NSString *address = @"127.0.0.1";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}
// 获取UUID
- (NSString*)getUUID{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *strUUID = nil;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    strUUID = [user objectForKey:@"uuid"];
    if (!strUUID) {
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        [user setObject:strUUID forKey:@"uuid"];
        [user synchronize];
    }
    return strUUID;
}

- (NSString*)returnStrPhone:(NSDictionary*)dict string:(NSString*)strPhoneOrigin{
    
    NSArray *searcgArr = @[@"QuickBankAuthent",@"QuickBankCardConfirm",@"SendDynamicCode",@"CheckDynamicCode",@"QuickBankCardComfirmSdjSms",@"QuickBankCardPaySdj",@"QuickBankCardPaySdjSms",@"QuickBankCardComfirmSdj",@"QuickBankCardConfirm",@"UnbindQuickBankCard"];
    
    NSString *str = [dict objectForKey:@"application"];
    NSString *strphone = [[NSString alloc] init];
    for (NSString *c in searcgArr) {
        if ([str isEqualToString:c]) {
            strphone = [[NSUserDefaults standardUserDefaults]  objectForKey: @"mobileNo"];
            return strphone;
        }else{
            
            return strPhoneOrigin;
        }
    }
    return nil;
}

@end
