//
//  NSString+EncodingUTF8Additions.h
//  selfService
//
//  Created by blue sky on 15/11/12.
//  Copyright © 2015年 sand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EncodingUTF8Additions)

/**
 *@brief 编码
 *@param param  数据
 *@return 返回NSString
 */
+(NSString *) URLEncodingUTF8String:(NSString *)param;

/**
 *@brief 编码
 *@param param  数据
 *@return 返回NSString
 */
+(NSString *) URLDecodingUTF8String:(NSString *)param;


@end
