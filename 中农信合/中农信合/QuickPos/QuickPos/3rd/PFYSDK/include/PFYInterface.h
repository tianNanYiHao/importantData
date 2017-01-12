//
//  NSObject+PFYInterface.h
//  WNFSDK
//
//  Created by 张士玉 on 16/9/22.
//  Copyright © 2016年 张士玉. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CompletionBlock)(NSDictionary *resultData);
@interface PFYInterface: NSObject
// SDK接入
+ (void)connectSDKWithMerchorder_no:(NSString *)merchorder_no orderinfo:(NSString *)orderinfo merchantcode:(NSString *)merchantcode backurl:(NSString *)backurl money:(NSString *)money transdate:(NSString *)transdate key:(NSString *)key reqreserved:(NSString *)reqreserved standbyCallback:(CompletionBlock)completionBlock;
// 微信 SDK生成二维码接入
+ (void)connectWXCreateQRcodeWithMerchantcode:(NSString *)merchantcode money:(NSString *)money transdate:(NSString *)transdate key:(NSString *)key reqreserved:(NSString *)reqreserved standbyCallback:(CompletionBlock)completionBlock;
// 微信 SDK扫描二维码接入
+ (void)connectWXScanQRcodeWithMerchantcode:(NSString *)merchantcode money:(NSString *)money qrcode:(NSString *)qrcode transdate:(NSString *)transdate key:(NSString *)key reqreserved:(NSString *)reqreserved standbyCallback:(CompletionBlock)completionBlock;
// 支付宝 SDK生成二维码接入
+ (void)connectAlipayCreateQRcodeWithMerchantcode:(NSString *)merchantcode subject:(NSString *)subject money:(NSString *)money backurl:(NSString *)backurl transdate:(NSString *)transdate key:(NSString *)key reqreserved:(NSString *)reqreserved standbyCallback:(CompletionBlock)completionBlock;
// 支付宝 SDK扫描二维码接入
+ (void)connectAlipayScanQRcodeWithMerchantcode:(NSString *)merchantcode money:(NSString *)money qrcode:(NSString *)qrcode subject:(NSString *)subject transdate:(NSString *)transdate key:(NSString *)key reqreserved:(NSString *)reqreserved standbyCallback:(CompletionBlock)completionBlock;



// 银行卡 交易结果查询
+ (void)payResultSelectWithMerchorder_no:(NSString *)merchorder_no queryId:(NSString *)queryId merchantcode:(NSString *)merchantcode transdate:(NSString *)transdate key:(NSString *)key standbyCallback:(CompletionBlock)completionBlock;
// 微信 订单状态查询
+ (void)wxOrderStateSelectWithMerchantcode:(NSString *)merchantcode merchorder_no:(NSString *)merchorder_no isloop:(NSString *)isloop looptime:(NSString *)looptime transdate:(NSString *)transdate key:(NSString *)key standbyCallback:(CompletionBlock)completionBlock;
// 微信 撤销订单
+ (void)wxRevocationOrderWithMerchantcode:(NSString *)merchantcode merchorder_no:(NSString *)merchorder_no transdate:(NSString *)transdate key:(NSString *)key standbyCallback:(CompletionBlock)completionBlock;
// 微信 退款
+ (void)wxDrawbackWithMerchantcode:(NSString *)merchantcode merchorder_no:(NSString *)merchorder_no money:(NSString *)money transdate:(NSString *)transdate key:(NSString *)key standbyCallback:(CompletionBlock)completionBlock;
// 支付宝 订单状态查询
+ (void)alipayOrderStateSelectWithMerchantcode:(NSString *)merchantcode merchorder_no:(NSString *)merchorder_no smzfMsgId:(NSString *)smzfMsgId transdate:(NSString *)transdate key:(NSString *)key standbyCallback:(CompletionBlock)completionBlock;
// 支付宝 交易撤销
+ (void)alipayRevocationOrderWithMerchantcode:(NSString *)merchantcode merchorder_no:(NSString *)merchorder_no smzfMsgId:(NSString *)smzfMsgId transdate:(NSString *)transdate key:(NSString *)key standbyCallback:(CompletionBlock)completionBlock;

@end
