//
//  SDAlertControllerUtil.m
//  UIControlAlertSheet
//
//  Created by tianNanYiHao on 2017/9/1.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDAlertControllerUtil.h"
#import "PSTAlertController.h"

@implementation SDAlertControllerUtil



+ (void)showAlertControllerWihtTitle:(NSString*)title message:(NSString*)message actionArray:(NSArray*)actionArray presentedViewController:(UIViewController*)viewController actionBlock:(SDAlertControllerActionBlock)actionBlock{
    
    PSTAlertController *pstaAlerController = [PSTAlertController alertControllerWithTitle:title message:message preferredStyle:PSTAlertControllerStyleActionSheet];
    
    for (int i = 0; i<actionArray.count; i++) {
        NSString *acctionTitle = actionArray[i];
        
        [pstaAlerController addAction:[PSTAlertAction actionWithTitle:acctionTitle handler:^(PSTAlertAction * _Nonnull action) {
            actionBlock(i);
        }]];
    }
    [pstaAlerController showWithSender:nil controller:viewController animated:YES completion:nil];
}
    


@end
