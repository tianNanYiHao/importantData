//
//  SandMajlet.h
//  sandbao
//
//  Created by blue sky on 2017/4/13.
//  Copyright © 2017年 sand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SandMajletDelete <NSObject>

- (void)SandMajletIndex:(NSInteger)paramInt paramString:(NSString *)paramString;

@end

/**
 * js调用oc里 main的代码，需要借助这个协议才行
 */
@protocol JSObjectProtocol <JSExport>

@required
#pragma mark -js调用该oc方法，并且将jsonstring打印出来
- (void)Pay:(NSString *)param;

- (void)Jump:(NSString *)param;

- (void)JumpWithBarMenu:(NSString *)param1 param2:(NSString *)param2;

- (void)SetBarMenu:(id )barMenu;




@end

@interface SandMajlet : NSObject<JSObjectProtocol>

@property (nonatomic, strong) id<SandMajletDelete> delegate;

@end
