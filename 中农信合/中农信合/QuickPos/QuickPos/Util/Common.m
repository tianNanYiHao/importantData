//
//  Common.m
//  QuickPos
//
//  Created by 胡丹 on 15/3/23.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "Common.h"

@implementation Common

+(BOOL)isPhoneNumber:(NSString*)phone{

    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:phone] == YES)
        
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(void)showMsgBox:(NSString*)title msg:(NSString*)msg parentCtrl:(id)ctrl{
    if(iOS8){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        }];
        [alert addAction:defaultAction];
        [(UIViewController*)ctrl presentViewController:alert animated:YES completion:nil];
    
    }else{
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alert show];
    
    }
    
}

+ (NSString *)orderAmtFormat:(NSString*)orderAmt{
    NSString *newOrderAmt = [NSString stringWithFormat:@"%.2f",[orderAmt floatValue]];
    newOrderAmt = [newOrderAmt stringByReplacingOccurrencesOfString:@"." withString:@""];
    return newOrderAmt;
}

+ (NSString *)rerverseOrderAmtFormat:(NSString*)orderAmt{
    NSString *newOrderAmt = [NSString stringWithFormat:@"%.2f",[orderAmt doubleValue]/100];
    return newOrderAmt;
}

+ (NSString*)bankCardNumSecret:(NSString*)cardNum{
    for (int i = 0 ; i < cardNum.length - 4;i ++) {
        cardNum = [cardNum stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
    }
    return cardNum;
}

//16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}

+ (void)setExtraCellLineHidden:(UITableView *)tableView//隐藏多余的分割线
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}


//图片压缩
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

//判断整数
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

+ (NSString *)getCurrentVersion {
    NSString *version = @"";
    version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+ (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

+(void)pstaAlertWithTitle:(NSString*)title message:(NSString*)message defaultTitle:(NSString*)defaultTitle cancleTitle:(NSString*)cancaleTitle defaultBlock:(CommonShowBoxdefaultBlock)defaultBlock CancleBlock:(CommonShowBoxcancleBlock)cacleBlock ctr:(UIViewController*)ctrller{
    
    PSTAlertController *past = [PSTAlertController alertWithTitle:title message:message];
    [past addAction:[PSTAlertAction actionWithTitle:defaultTitle handler:^(PSTAlertAction * _Nonnull action) {
        defaultBlock(action);
    } ]];
    
    [past addAction:[PSTAlertAction actionWithTitle:cancaleTitle handler:^(PSTAlertAction * _Nonnull action) {
        cacleBlock(action);
    }]];
    [past showWithSender:nil controller:ctrller animated:YES completion:NULL];
    
}


+ (UIView*)tipWithStr:(NSString*)str color:(UIColor*)color rect:(CGRect)frame{
    UIView *bsetView = [[UIView alloc] initWithFrame:frame];
    bsetView.backgroundColor = [self hexStringToColor:@"ffffff"];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    title.text = str;
    title.textColor = color;
    title.font = [UIFont systemFontOfSize:13];
    title.textAlignment = NSTextAlignmentCenter;
    [bsetView addSubview:title];
    return bsetView;
    
}

+(void)getYSTZFBimage:(UIView*)view  money:(NSString*)moneY requestDataBlock:(YSTZFBEWMBlock)requestBlock infoArr:(NSArray*)arr{
    [Common linkYSTSDK];    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *transDate = [formatter stringFromDate:[NSDate date]];
    
    NSString *subject = @"上海捷丰网络科技有限公司";
    NSString *merchantcode = arr[0];
    NSString *backurl = arr[1];
    NSString *money = moneY;
    NSString *transdate = transDate;
    NSString *key = arr[2];
    NSString *reqreserved = @"123456789";
    [PFYInterface connectAlipayCreateQRcodeWithMerchantcode:merchantcode subject:subject money:money backurl:backurl transdate:transdate key:key reqreserved:nil standbyCallback:^(NSDictionary *resultData) {
        if (resultData == nil) {
            [MyAlertView myAlertView:@"请检查你的网络连接"];
            return;
        }
        requestBlock(resultData);
    }];
 }
+(NSString*)returnStr:(NSString*)str{
    return str;
}
#pragma mark 接入SDK
+ (void)linkYSTSDK {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *transDate = [formatter stringFromDate:[NSDate date]];
    NSString *merchorder_no = [NSString stringWithFormat:@"%@%06d", transDate, arc4random()%1000000];
    NSString *orderinfo = @"上海捷丰网络科技有限公司";
    NSString *merchantcode = ZFBMERCHANTCODE;
    NSString *backurl = ZFBBACKURL;
    NSString *money = @"0.01";
    NSString *transdate = transDate;
    NSString *key = ZFBKEY;
    NSString *reqreserved = @"123456789";
    [PFYInterface connectSDKWithMerchorder_no:merchorder_no orderinfo:orderinfo merchantcode:merchantcode backurl:backurl money:money transdate:transdate key:key reqreserved:nil standbyCallback:^(NSDictionary *resultData) {
        if (resultData == nil) {
            [MyAlertView myAlertView:@"请检查你的网络连接"];
            return;
        }
        NSData *data = (NSData*)resultData;
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"3%@",str);
    }];
}
//////////////////////////////华丽的分割线/////////////////////////////////////////
//***************************二维码生成功能****************************************
+(void)erweima:(NSString *)qrcode imageView:(UIImageView*)iamgeView{
    //二维码滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    [filter setDefaults];
    //将字符串转换成NSData
    NSData *data = [qrcode dataUsingEncoding:NSUTF8StringEncoding];
    //通过KVO设置滤镜inputmessage数据
    [filter setValue:data forKey:@"inputMessage"];
    //获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    //将CIImage转换成UIImage,并放大显示
    iamgeView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:500.0];
    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
    iamgeView.layer.shadowOffset = CGSizeMake(0, 0.5);//设置阴影的偏移量
    iamgeView.layer.shadowRadius = 1;//设置阴影的半径
    iamgeView.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影的颜色为黑色
    iamgeView.layer.shadowOpacity = 0.3;
}

//改变二维码或条形码的大小
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark 支付宝 订单状态查询
+ (void)alipayOrderStateSelect:(NSString *)merchorder_no key:(NSString *)key merchantcode:(NSString*)merchantcodE{
    //    PFYProgressHUD *pfyViewHUD = [[PFYProgressHUD alloc] initViewWithFrame:self.view.frame];
    //    [self.view addSubview:pfyViewHUD];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *transDate = [formatter stringFromDate:[NSDate date]];
    NSString *merchantcode = merchantcodE;
    NSString *transdate = transDate;
    [PFYInterface alipayOrderStateSelectWithMerchantcode:merchantcode merchorder_no:merchorder_no smzfMsgId:@"" transdate:transdate key:key standbyCallback:^(NSDictionary *resultData) {
        if (resultData == nil) {
            [MyAlertView myAlertView:@"请检查你的网络连接"];
            return;
        }
        NSData *data = (NSData*)resultData;
        NSMutableString *str = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", dict);
        //        NSString *retcode = [dict objectForKey:@"retcode"];
        NSString *result = [dict objectForKey:@"result"];
        [MyAlertView myAlertView:[NSString stringWithFormat:@"您的二维码:%@",result]];
        //        if ([retcode isEqualToString:@"00"]) {
        //
        //            self.imageView.image = [UIImage imageNamed:@""];
        //        }
    }];
}

@end
