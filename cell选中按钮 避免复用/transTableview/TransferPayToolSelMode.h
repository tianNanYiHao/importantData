//
//  TransferPayToolSelMode.h
//  transTableview
//
//  Created by tianNanYiHao on 2017/3/27.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransferPayToolSelMode : NSObject

@property(nonatomic,assign) BOOL selected;


@property(nonatomic,strong) NSString *headImageOther;
@property(nonatomic,strong) NSString *headImageOwn;

@property (nonatomic,strong) NSString *payToolTitle;
@property (nonatomic,strong) NSString *paytTooldescribe;

@property (nonatomic,assign) NSInteger index;



@end
