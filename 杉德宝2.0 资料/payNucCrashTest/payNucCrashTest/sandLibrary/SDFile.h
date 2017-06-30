//
//  SDFile.h
//  sandbaocontrol
//
//  Created by blue sky on 2016/11/24.
//  Copyright © 2016年 sand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDFile : NSObject

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *fileNameKey;
@property (nonatomic, strong) NSString *fileType;
@property (nonatomic, strong) NSString *fileMimiType;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSData *fileData;


/**
 *@brief 创建单例
 */
+ (SDFile *)shareSDFile;


/**
 *@brief 文件简类型
 *@param paramData NSData 参数标示：文件数据
 *@return
 */
- (NSString *)dataWithFileType:(NSData *)paramData;

/**
 *@brief 文件全类型
 *@param param NSString 参数标示：文件名
 *@return
 */
- (NSString*)stringWithFileType:(NSString*)param;

@end
