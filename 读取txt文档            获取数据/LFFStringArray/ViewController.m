//
//  ViewController.m
//  LFFStringArray
//
//  Created by Lff on 16/10/14.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "ViewController.h"
#import "LFFStringarr.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LFFStringarr *lff = [[LFFStringarr alloc]init];
    LFFJieFengCompenyInfo *mode =   [lff getJieFengCompenyInfoModel];
    NSLog(@"%ld,%ld,%ld",mode.arrJFNO.count,mode.arrJFKey.count,mode.arrJFName.count);
    for (NSString *s in mode.arrJFNO) {
        NSLog(@"%@",s);
    }
    for (NSString *s in mode.arrJFKey) {
        NSLog(@"%@",s);
    }
    for (NSString *s in mode.arrJFName) {
        NSLog(@"%@",s);
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
