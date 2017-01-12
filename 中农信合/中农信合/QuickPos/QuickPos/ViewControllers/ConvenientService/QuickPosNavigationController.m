//
//  QuickPosNavigationController.m
//  QuickPos
//
//  Created by Leona on 15/4/3.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "QuickPosNavigationController.h"
#import "Common.h"
@interface QuickPosNavigationController ()
@end

@implementation QuickPosNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//原来的样式
//    self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont fontWithName:@"huxiaobo-gdh" size:20]};
    //新的样式
    self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:17]};
    
    if([UIDevice currentDevice].isIOS6){
        
              
//        item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
//        
//        self.navigationItem.backBarButtonItem = item;
        
        
        self.navigationBar.tintColor = [Common hexStringToColor:@"4082C5"];
        
    }
    
}

@end
