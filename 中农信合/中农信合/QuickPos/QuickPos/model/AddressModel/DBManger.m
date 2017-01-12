//
//  DBManger.m
//  QuickPos
//
//  Created by Aotu on 15/11/10.
//  Copyright © 2015年 张倡榕. All rights reserved.
//

#import "DBManger.h"
#import "FMDatabase.h"
#import "AddressModel.h"

@interface DBManger ()
{
    FMDatabase *_fmdb; //数据库对象
    NSLock *_lock;
    
}
@end

static DBManger *_db;

@implementation DBManger
+(instancetype)sharDBManager
{
    static dispatch_once_t fmdb;
    dispatch_once(&fmdb,^{
        _db = [[DBManger alloc] init];
    });
    return _db;
}

-(instancetype)init
{
    if (self = [super init]) {
        //创建数据库
        NSString *depath = [NSHomeDirectory() stringByAppendingString:@"/Documents/app.db"];
        _fmdb = [FMDatabase databaseWithPath:depath];
        
        //打开数据库
        BOOL isOpen = [_fmdb open];
        if (isOpen) {
            NSString *sql = @"create table if not exists app (nametext varchar(100),phonetext varchar(100),addresstext varchar(100))";
            //执行sql
            BOOL isSuccess = [_fmdb executeUpdate:sql];
            if (isSuccess) {
                NSLog(@"建表成功");
            }else
            {
                NSLog(@"建表失败");
            }
            
        }else
        {
            NSLog(@"打开失败");
        }
        
    }return self;
    
}

//插入数据
//-(BOOL)insertDataWithAddressModel:(AddressModel*)model;
//{
//    [_lock lock];
//    NSString *sql = @"insert into app values(?,?,?)";
//    
//
//    return <#expression#>
//    
//}



























@end
