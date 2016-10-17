//
//  AddressModel.h
//  QuickPos
//
//  Created by Lff on 16/10/9.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TrickInfoModel : NSObject
@property (nonatomic,strong)NSString *addName;
@property (nonatomic,strong)NSString *addCode;
- (NSArray*)getInfoBack;

@end


@interface TrickAddressModel : NSObject
+(NSArray*)getBackDict;

@end





