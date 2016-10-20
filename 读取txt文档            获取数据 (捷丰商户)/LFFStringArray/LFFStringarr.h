//
//  LFFStringarr.h
//  LFFStringArray
//
//  Created by Lff on 16/10/14.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LFFJieFengCompenyInfo : NSObject
@property (nonatomic,strong) NSMutableArray *arrJFName;
@property (nonatomic,strong) NSMutableArray *arrJFNO;
@property (nonatomic,strong) NSMutableArray *arrJFKey;
@end


@interface LFFStringarr : NSObject
-(LFFJieFengCompenyInfo*)getJieFengCompenyInfoModel;

@end



