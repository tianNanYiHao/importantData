//
//  XML.h
//  QuickPos
//
//  Created by 糊涂 on 15/3/18.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XML : NSObject
// 解析报文
- (NSDictionary*)deXMLWithData:(NSData*)data;
- (NSDictionary*)deXMLWithString:(NSString*)string;
// 生成报文
- (NSString*)xmlDataWithDict:(NSDictionary*)dic;
@end
