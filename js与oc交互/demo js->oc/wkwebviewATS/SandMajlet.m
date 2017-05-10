//
//  SandMajlet.m
//  sandbao
//
//  Created by blue sky on 2017/4/13.
//  Copyright © 2017年 sand. All rights reserved.
//

#import "SandMajlet.h"


@implementation SandMajlet

- (void)Pay:(NSString *)TN
{
    [self.delegate SandMajletIndex:0 paramString:TN];

}

- (void)Jump:(NSString *)param
{
    
}

- (void)JumpWithBarMenu:(NSString *)param1 param2:(NSString *)param2
{
    
}

- (void)SetBarMenu:(id )barMenu{
    
    [self.delegate SandMajletIndex:3 paramString:barMenu];

    
}

@end
