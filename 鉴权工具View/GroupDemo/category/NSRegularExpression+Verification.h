//
//  NSRegularExpression+Verification.h
//  aunnalMeeting
//
//  Created by blue sky on 15/1/12.
//  Copyright (c) 2015年 sand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSRegularExpression (Verification)

/**
 *@brief 是否为空
 *@param param 字符串 参数：字符串
 *@return 返回BOOL
 */
+ (BOOL) isNil:(NSString *)param;

/**
 *@brief 邮箱
 *@param email 字符串 参数：邮箱
 *@return 返回BOOL
 */
+ (BOOL) validateEmail:(NSString *)email;

/**
 *@brief 固定电话号码验证
 *@param mobile 字符串 参数：固定电话号码验证
 *@return 返回BOOL
 */
+ (BOOL) validateFixedTelPhone:(NSString *)mobile;

/**
 *@brief 手机号码验证  手机号以13， 15，18开头，八个 \d 数字字符
 *@param mobile 字符串 参数：手机号码验证
 *@return 返回BOOL
 */
+ (BOOL) validateMobile:(NSString *)mobile;

/**
 *@brief 营业注册号码验证
 *@param mobile 字符串 参数：固定电话号码验证
 *@return 返回BOOL
 */
+ (BOOL) validateBusinessLicenseNumber:(NSString *)BusinessLicenseNumber;

/**
 *@brief 车牌号验证
 *@param carNo 字符串 参数：车牌号验证
 *@return 返回BOOL
 */
+ (BOOL) validateCarNo:(NSString *)carNo;

/**
 *@brief 车型
 *@param CarType 字符串 参数：车型
 *@return 返回BOOL
 */
+ (BOOL) validateCarType:(NSString *)CarType;

/**
 *@brief 用户名
 *@param name 字符串 参数：用户名
 *@return 返回BOOL
 */
+ (BOOL) validateUserName:(NSString *)name;

/**
 *@brief 6位到20位 数字和字母 密码
 *@param passWord 字符串 参数：密码
 *@return 返回BOOL
 */
+ (BOOL) validatePassword:(NSString *)passWord;

/**
 *@brief 数字和字母组合密码
 *@param passWord 字符串 参数：密码
 *@return 返回BOOL
 */
+ (BOOL) validatePasswordNumAndLetter:(NSString *)passWord;

/**
 *@brief 数字和字母组合
 *@param param 字符串 参数：参数
 *@return 返回BOOL
 */
+ (BOOL) validateNumAndLetter:(NSString *)param;

/**
 *@brief 登录名
 *@param loginName 字符串 参数： 登录名
 *@return 返回BOOL
 */
+ (BOOL) validateLoginName:(NSString *)loginName;

/**
 *@brief 昵称
 *@param nickname 字符串 参数：昵称
 *@return 返回BOOL
 */
+ (BOOL) validateNickname:(NSString *)nickname;

/**
 *@brief 身份证号
 *@param identityCard 字符串 参数：身份证号
 *@return 返回BOOL
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/**
 *@brief 银行卡
 *@param identityCard 字符串 参数：银行卡号
 *@return 返回BOOL
 */
+ (BOOL) validateBankCard: (NSString *)bankNum;

/**
 *@brief 业务证件号
 *@param businessNum 字符串 参数：业务证件号
 *@return 返回BOOL
 */
+ (BOOL) validatebBusinessNum: (NSString *)businessNum;

/**
 *@brief  验证特殊字符
 *@param specialChar 字符串 参数：输入字符串
 *@return 返回BOOL
 */
+ (BOOL) validateSpecialChar:(NSString *)specialChar;

/**
 *@brief  验证空格字符
 *@param blankChar 字符串 参数：输入字符串
 *@return 返回BOOL
 */
+ (BOOL) validateSpecialBlankChar:(NSString *)blankChar;

/**
 *@brief 纯数字验证
 *@param pureNum 字符串 参数：纯数字
 *@return 返回BOOL
 */
+ (BOOL) validatePureNum:(NSString *)pureNum;

@end
