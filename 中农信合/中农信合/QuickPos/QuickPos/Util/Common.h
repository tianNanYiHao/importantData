//
//  Common.h
//  QuickPos
//
//  Created by 胡丹 on 15/3/23.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CommonShowBoxdefaultBlock)(id defaultBlock);
typedef void(^CommonShowBoxcancleBlock)(id cancleBlock);
typedef void (^YSTZFBEWMBlock)(id requestdate);

@interface Common : NSObject

//判断是否为手机号码
+(BOOL)isPhoneNumber:(NSString*)phone;

//消息框
+(void)showMsgBox:(NSString*)title msg:(NSString*)msg parentCtrl:(id)ctrl;

+ (NSString *)orderAmtFormat:(NSString*)orderAmt;
+ (NSString *)rerverseOrderAmtFormat:(NSString*)orderAmt;
+ (NSString*)bankCardNumSecret:(NSString*)cardNum;

+ (UIColor *) hexStringToColor: (NSString *) stringToConvert;

+ (void)setExtraCellLineHidden:(UITableView *)tableView;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (BOOL)isPureInt:(NSString*)string;

+ (NSString*)getCurrentVersion;

+ (UIImage *) createImageWithColor: (UIColor *) color;

+(void)pstaAlertWithTitle:(NSString*)title message:(NSString*)message defaultTitle:(NSString*)defaultTitle cancleTitle:(NSString*)cancaleTitle defaultBlock:(CommonShowBoxdefaultBlock)defaultBlock CancleBlock:(CommonShowBoxcancleBlock)cacleBlock ctr:(UIViewController*)ctrller;

+ (UIView*)tipWithStr:(NSString*)str color:(UIColor*)color rect:(CGRect)frame;

+(void)getYSTZFBimage:(UIView*)view  money:(NSString*)moneY requestDataBlock:(YSTZFBEWMBlock)requestBlock infoArr:(NSArray*)arr;
+(void)erweima:(NSString *)qrcode imageView:(UIImageView*)iamgeView;
+ (void)alipayOrderStateSelect:(NSString *)merchorder_no key:(NSString *)key merchantcode:(NSString*)merchantcodE;
@end
