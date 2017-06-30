//
//  SDSqlite.h
//  sandbaocontrol
//
//  Created by blue sky on 2016/12/6.
//  Copyright © 2016年 sand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SDSqlite : NSObject

/**
 *@brief 创建数据库
 *@param databaseName    字符串  数据库名称
 *@return
 */
+ (NSString *)createDatabase:(NSString *)databaseName;

/**
 *@brief 打开数据库
 *@param path NSString  数据库地址
 *@return BOOL
 */
+ (sqlite3 *)open:(NSString *)path;

/**
 *@brief 关闭数据库
 *@param sqlite sqlite3  数据库
 *@return BOOL
 */
+ (BOOL)close:(sqlite3 *)sqlite;

/**
 *@brief 根据不同版本执行不同的升级逻辑
 *@param oldVersion NSInteger  老版本号
 *@return
 */
- (void)upgrade:(NSInteger)oldVersion ;

/**
 *@brief 判断表是否存在
 *@param sqlite sqlite3  数据库
 *@param 字符串 tableName 表名称
 *@return BOOL
 */

+ (BOOL)tableExists:(sqlite3 *)sqlite tableName:(NSString *)tableName;


/**
 *@brief 还原id主键值为0
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@return BOOL
 */
+ (BOOL)restoreID:(sqlite3 *)sqlite tableName:(NSString *)tableName;

/**
 *@brief 创建表
 *@param sqlite sqlite3  数据库
 *@param sql    字符串  创建表sql字符串
 *@return BOOL
 */
+ (BOOL)createTable:(sqlite3 *)sqlite sql:(NSString *)sql;

/**
 *@brief 删除表
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  删除表明字符串
 *@return BOOL
 */
+ (BOOL)dropTable:(sqlite3 *)sqlite tableName:(NSString *)tableName;

/**
 *@brief 插入数据
 *@param sqlite sqlite3  数据库
 *@param sql  NSString  插入sql语句字符串
 *@return BOOL
 */
+ (BOOL)insertData:(sqlite3 *)sqlite sql:(NSString *)sql;

/**
 *@brief 插入数据
 *@param sqlite sqlite3  数据库
 *@param tableName  NSString  表名字
 *@param columnArray  NSArray  列数组
 *@param paramArray  NSArray  列值数组
 *@return BOOL
 */
+ (BOOL)insertData:(sqlite3 *)sqlite tableName:(NSString *)tableName columnArray:(NSMutableArray *) columnArray paramArray:(NSMutableArray *)paramArray;

/**
 *@brief 更新数据
 *@param sqlite sqlite3  数据库
 *@param sql    字符串  更新sql语句字符串
 *@return BOOL
 */
+ (BOOL)updateData:(sqlite3 *)sqlite sql:(NSString *)sql;

/**
 *@brief 更新数据
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@param columnArray  数组  表的列名称
 *@param paramArray   数组   表的列的值
 *@param whereColumnString  字符串  表的列名称
 *@param whereParamString   字符串   表的列的值
 *@return BOOL
 */
+ (BOOL)updateData:(sqlite3 *)sqlite tableName:(NSString *)tableName columnArray:(NSMutableArray *) columnArray paramArray:(NSMutableArray *)paramArray whereColumnString:(NSString *) whereColumnString whereParamString:(NSString *)whereParamString;

/**
 *@brief 删除数据
 *@param sqlite sqlite3  数据库
 *@param sql    字符串  删除sql语句字符串
 *@return BOOL
 */
+ (BOOL)deleteData:(sqlite3 *)sqlite sql:(NSString *)sql;

/**
 *@brief 删除数据
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@param whereColumnString  字符串  表的列名称
 *@param whereParamString   字符串   表的列的值
 *@return BOOL
 */
+ (BOOL)deleteData:(sqlite3 *)sqlite tableName:(NSString *)tableName whereColumnString:(NSString *)whereColumnString whereParamString:(NSString *)whereParamString;

/**
 *@brief 删除表所有数据
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@return BOOL
 */

+ (BOOL)deleteAllData:(sqlite3 *)sqlite tableName:(NSString *) tableName;

/**
 *@brief 查询数据
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@param columnArray  数组  表的列名称
 *@return NSMutableArray
 */
+ (NSMutableArray *)selectData:(sqlite3 *)sqlite tableName:(NSString *) tableName columnArray:(NSMutableArray *) columnArray;

/**
 *@brief 根据条件查询数据
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@param columnArray  数组  表的列名称
 *@param whereColumnString  字符串  表的列名称
 *@param whereParamString   字符串   表的列的值
 *@return NSMutableArray
 */

+ (NSMutableArray *)selectWhereData:(sqlite3 *)sqlite tableName:(NSString *) tableName columnArray:(NSMutableArray *) columnArray whereColumnString:(NSString *) whereColumnString whereParamString:(NSString *)whereParamString;

/**
 *@brief 根据条件查询数据
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@param columnArray  数组  表的列名称
 *@param whereColumnStringOne  字符串  表的列名称
 *@param whereParamStringOne   字符串   表的列的值
 *@param whereColumnStringTwo  字符串  表的列名称
 *@param whereParamStringTwo   字符串   表的列的值
 *@return NSMutableArray
 */

+ (NSMutableArray *)selectWhereData:(sqlite3 *)sqlite tableName:(NSString *) tableName columnArray:(NSMutableArray *) columnArray whereColumnStringOne:(NSString *) whereColumnStringOne whereParamStringOne:(NSString *)whereParamStringOne whereColumnStringTwo:(NSString *) whereColumnStringTwo whereParamStringTwo:(NSString *)whereParamStringTwo;

/**
 *@brief 分页查询数据
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@param columnArray  数组  表的列名称
 *@param whereColumnString  字符串  表的列名称
 *@param whereParamString   字符串   表的列的值
 *@param limit   整形   分页
 *@return NSMutableArray
 */

+ (NSMutableArray *)selectLimitData:(sqlite3 *)sqlite tableName:(NSString *)tableName columnArray:(NSMutableArray *)columnArray whereColumnString:(NSString *)whereColumnString whereParamString:(NSString *)whereParamString limit:(int) limit;

/**
 *@brief 根据条件查询数据
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@param columnArray  数组  表的列名称
 *@param whereColumnString  字符串  表的列名称
 *@param whereParamString   字符串   表的列的值
 *@return NSMutableDictionary
 */

+ (NSMutableDictionary *)selectOneData:(sqlite3 *)sqlite tableName:(NSString *) tableName columnArray:(NSMutableArray *) columnArray whereColumnString:(NSString *) whereColumnString whereParamString:(NSString *)whereParamString;

/**
 *@brief 根据条件查询数据
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@param columnArray  数组  表的列名称
 *@param whereColumnStringOne  字符串  表的列名称
 *@param whereParamStringOne   字符串   表的列的值
 *@param whereColumnStringTwo  字符串  表的列名称
 *@param whereParamStringTwo   字符串   表的列的值
 *@return NSMutableDictionary
 */

+ (NSMutableDictionary *)selectOneData:(sqlite3 *)sqlite tableName:(NSString *) tableName columnArray:(NSMutableArray *) columnArray whereColumnStringOne:(NSString *) whereColumnStringOne whereParamStringOne:(NSString *)whereParamStringOne whereColumnStringTwo:(NSString *) whereColumnStringTwo whereParamStringTwo:(NSString *)whereParamStringTwo;

/**
 *@brief 查询一条数据
 *@param sqlite sqlite3  数据库
 *@param sql    字符串  执行SQL语句
 *@return NSString
 */
+(NSString *)selectStringData:(sqlite3 *)sqlite sql:(NSString *)sql;

/**
 *@brief 查询一条数据
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@param columnName  字符串  表的列名称
 *@param whereColumnString  字符串  表的列名称
 *@param whereParamString   字符串   表的列的值
 *@return NSString
 */
+(NSString *)selectStringData:(sqlite3 *)sqlite tableName:(NSString *)tableName columnName:(NSString *)columnName whereColumnString:(NSString *)whereColumnString whereParamString:(NSString *)whereParamString;

/**
 *@brief 查询一条数据
 *@param sqlite sqlite3  数据库
 *@param sql    字符串  执行SQL语句
 *@return int
 */
+(int)selectIntData:(sqlite3 *)sqlite sql:(NSString *)sql;

/**
 *@brief 查询一条数据
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@param columnName  字符串  表的列名称
 *@param whereColumnString  字符串  表的列名称
 *@param whereParamString   字符串   表的列的值
 *@return int
 */
+(int)selectIntData:(sqlite3 *)sqlite tableName:(NSString *)tableName columnName:(NSString *)columnName whereColumnString:(NSString *)whereColumnString whereParamString:(NSString *)whereParamString;

/**
 *@brief 查询表有多少条数据
 *@param sqlite sqlite3  数据库
 *@param sql    NSString   执行sql语句
 *@return long
 */
+ (long)getCount:(sqlite3 *)sqlite sql:(NSString *)sql;

/**
 *@brief 根据条件查询表有多少条数据
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@param columnString  字符串  表的列名称
 *@param paramString   字符串   表的列的值
 *@return long
 */
+ (long)getCount:(sqlite3 *)sqlite tableName:(NSString *)tableName columnString:(NSString *)columnString paramString:(NSString *)paramString;

/**
 *@brief 根据条件查询表有多少条数据
 *@param sqlite sqlite3  数据库
 *@param tableName    字符串  表名称
 *@param whereColumnStringOne  字符串  表的列名称
 *@param whereParamStringOne   字符串   表的列的值
 *@param whereColumnStringTwo  字符串  表的列名称
 *@param whereParamStringTwo   字符串   表的列的值
 *@return long
 */
+ (long)getCount:(sqlite3 *)sqlite tableName:(NSString *)tableName whereColumnStringOne:(NSString *) whereColumnStringOne whereParamStringOne:(NSString *)whereParamStringOne whereColumnStringTwo:(NSString *) whereColumnStringTwo whereParamStringTwo:(NSString *)whereParamStringTwo;

@end
