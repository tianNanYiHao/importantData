//
//  Util.h
//  QuickPos
//
//  Created by 糊涂 on 15/3/24.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (NSString*)base64Encode:(NSData*)data;
+ (NSData*)base64Decode:(NSString*)string;

+ (NSString*)urlDecode:(NSString*)data ;
+ (NSString*)urlEncode:(NSString*)data;

+ (NSString*)getImageWithData:(NSData*)data;

+ (NSString*)getImageWithImage:(UIImage*)img;

+ (NSString*)md5WithData:(NSData*)data ;
+ (NSString*)md5WithString:(NSString*)str;

@end
